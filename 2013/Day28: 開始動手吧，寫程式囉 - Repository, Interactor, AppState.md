定義完我們的資料流，就可以來寫我們的邏輯了！

# Repository
---
在 `Repository` 資料夾內新增 `Repository.swift`：
```swift
protocol Repository: TodoEventRepository {}

protocol TodoEventRepository {
    func listEvents() throws -> [TodoEvent]
    func saveEvent(_:TodoEvent) throws -> TodoEvent
    /*** return true if delete succeed */
    func deleteEvent(_:Int64) throws -> Bool
}
```

### SQLiteEventDao
在 `Repository` 資料夾內建立 `SQLite` 資料夾，並在裡面新增 `SQLiteEventDao.swift`：
```swift
import Foundation
import SQLite
import Sworm

protocol SQLiteEventDao {}

extension SQLiteEventDao where Self: TodoEventRepository {
    func listEvents() throws -> [TodoEvent] {
        let rows = try SQL.getDriver().query(TodoEvent.self) { $0.order(TodoEvent.id) }
        
        var result = [TodoEvent]()
        for row in rows {
            result.append(try TodoEvent.parse(row))
        }
        return result
    }
    
    func saveEvent(_ event: TodoEvent) throws -> TodoEvent {
        let id = try SQL.getDriver().insert(event)
        
        return TodoEvent(
            id: id,
            title: event.title,
            createAt: event.createAt,
            complete: event.complete
        )
    }
    
    func deleteEvent(_ id: Int64) throws -> Bool {
        let count = try SQL.getDriver().delete(TodoEvent.self) { $0.where(TodoEvent.id == id) }
        return count != 0
    }
}
```
### SQLiteDao
在 `SQLite` 資料夾內新增 `SQLiteDao.swift`：
```swift
protocol SQLiteDao: SQLiteEventDao {}
```

### Dao
在 `Repository` 資料夾內新增 `Dao.swift`：
```swift
import Foundation
import Sworm

struct Dao: SQLiteDao {
    init(isMock: Bool) {
        let db = SQL.setup(dbName: "database", isMock: isMock)
        db.migrate([TodoEvent.self])
    }
}

extension Dao: Repository {}
```

# AppState
---
在 `AppState` 資料夾內新增 `AppState.swift`：
```swift
import Foundation
import Combine

struct AppState {
    private static let `default` = AppState()
    
    var todoEvents = CurrentValueSubject<[TodoEvent], Never>([])
    var todoEventError = PassthroughSubject<Error?, Never>()
}

extension AppState {
    static func get() -> AppState { return .default }
}
```
> `todoEvents` 儲存目前所有待辦事項
>
> 這邊多建立一個 `todoEventError` 來回傳任何執行的錯誤

# Interactor
---

### TodoEventInteractor
在 `Interactor` 資料夾內新增 `TodoEventInteractor.swift`：
```swift
import Foundation
import Ditto

struct TodoEventService {
    private let appState: AppState
    private let repo: Repository
    
    init(appState: AppState, repo: Repository) {
        self.appState = appState
        self.repo = repo
    }
}

extension TodoEventService: TodoEventInteractor {
    func listEvents() {
        System.async {
            do {
                let events = try repo.listEvents()
                appState.todoEvents.send(events)
            } catch {
                appState.todoEvents.send([])
                appState.todoEventError.send(error)
            }
        }
    }
    
    func createEvent(_ event: TodoEvent) {
        System.async {
            do {
                let created = try repo.saveEvent(event)
                var value = appState.todoEvents.value
                value.append(created)
                appState.todoEvents.send(value)
            } catch {
                appState.todoEventError.send(error)
            }
        }
    }
    
    func deleteEvent(_ event: TodoEvent) {
        System.async {
            do {
                if try repo.deleteEvent(event.id) {
                    var value = appState.todoEvents.value
                    value.removeAll { $0.id == event.id }
                    appState.todoEvents.send(value)
                } else {
                    throw TodoEvent.Errors.recordNotFound
                }
            } catch {
                appState.todoEventError.send(error)
            }
        }
    }
}

extension TodoEvent {
    enum Errors: String, Error {
    case recordNotFound = "record not found"
    }
}
```

> `System.async` 是 `Ditto` 內的一個方法，可以在 `background thread` 內呼叫 `main thread` 執行程式

### Interactor
在 `Interactor` 資料夾內新增 `Interactor.swift`：
```swift
import Foundation

struct Interactor {
    private static var `default`: Interactor?
    
    var todoEvent: TodoEventInteractor
    
    init(appState: AppState, isMock: Bool) {
        let repo = Dao(isMock: isMock)
        self.todoEvent = TodoEventService(appState: appState, repo: repo)
    }
}

extension Interactor {
    static func get(isMock: Bool) -> Interactor {
        if Interactor.default == nil {
            Interactor.default = Interactor(appState: .get(), isMock: isMock)
        }
        return Interactor.default!
    }
}

protocol TodoEventInteractor {
    func listEvents()
    func createEvent(_:TodoEvent)
    func deleteEvent(_:TodoEvent)
}
```

# DIContainer
---
### DIContainer
在 `System` 資料夾內新增 `DependencyInjector.swift`：
```swift
extension DIContainer {
    var appState: AppState { .get() }
    var interactor: Interactor { .get(isMock: isMock) }
}
```

# 總結
---
將前幾章所學的好好發揮吧！寫程式好快樂！