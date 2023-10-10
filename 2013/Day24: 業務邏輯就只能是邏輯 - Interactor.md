接下來就要來實作最重要的 `Interactor` 部分了！有沒有很期待？

# Interactor 實作
---

在 `Clean Architecture` 章節，我們定義了 `Interactor`：
```swift
struct Interactor {
    var member: MemberInteractor
}

protocol MemberInteractor {
    func getAllMember()
    func saveMember(_:Member) -> Bool
    func updateMember(_:Member) -> Bool
    func deleteMember(_:Member) -> Bool
}
```

接著我們要來實作他，首先在 `Interactor` 資料夾新增 `MemberInteractor.swift`。

接著定義結構 `MemberInteractorService` 來實作 `MemberInteractor`：

> 我們需要把 `AppState` 及 `Repository` 傳進每個 `Interactor` 內部

![https://ithelp.ithome.com.tw/upload/images/20231009/20162383X1B6QSjTpp.png](https://ithelp.ithome.com.tw/upload/images/20231009/20162383X1B6QSjTpp.png)

```swift
import Foundation

struct MemberInteractorService {
    private var appState: AppState
    private var repo: Repository
    
    init(appState: AppState, repo: Repository) {
        self.appState = appState
        self.repo = repo
    }
}

extension MemberInteractorService: MemberInteractor {
    func getAllMember() {
        do {
            let member = try repo.getMember(nil, nil)
            appState.members.send(member)
        } catch {
            print("get all members error: \(error)")
            appState.members.send(nil)
        }
    }
    
    func saveMember(_ member: Member) -> Bool {
        do {
            _ = try repo.saveMember(member)
            getAllMember()
            return true
        } catch {
            print("save member \(member) error: \(error)")
            return false
        }
    }
    
    func updateMember(_ member: Member) -> Bool {
        do {
            try repo.updateMember(member)
            getAllMember()
            return true
        } catch {
            print("update member \(member) error: \(error)")
            return false
        }
    }
    
    func deleteMember(_ member: Member) -> Bool {
        do {
            try repo.deleteMember(member)
            getAllMember()
            return true
        } catch {
            print("delete member \(member) error: \(error)")
            return false
        }
    }
}
```

# Interactor Init 方法
---
因為定義好了 `MemberInteractorService` 所以我們要調整一下 `Interactor` 的 `init` 方法：
```swift
struct Interactor {
    var member: MemberInteractor
    
    init(appState: AppState, repo: Repository) {
        self.member = MemberInteractorService(appState: appState, repo: repo)
    }
}
```

> 這邊將 `AppState` 及 `Repository` 傳進來是一種依賴注入
>
> 未來要抽換 `AppState` `Repository`，只需要從外部更改即可

# DIContainer Init 方法 & Dao 調整
---
還記得我們的 `DIContainer` 內存的是 `AppState?` 和 `Interactor?` 兩個 `Optional` 嗎？

我們要調整一下他們，並在 `init` 帶入一個 `isMock` 參數來判斷是否是測試用的。

判斷測試主要是，如果是測試的話，資料庫也需要用假的，所以 `Dao` 也會需要改：

> Dao

```swift
struct Dao: SQLiteDao {
    init(isMock: Bool) {
        let conn = SQL.setup(dbName: "database", isMock: isMock)
        conn.migrate([Member.self])
    }
}
```

> DIContainer
```swift
struct DIContainer {
    var appState: AppState
    var interactor: Interactor
    
    init(isMock: Bool = false) {
        let repo = Dao(isMock: isMock)
        let state = AppState()
        
        self.appState = state
        self.interactor = Interactor(appState: state, repo: repo)
    }
}
```

# ContentView
---
最後我們要把 `ContentView` 調整一下。

首先把 `onReceive` 中 `appState!` 的 `!` 拿掉：

```swift
.onReceive(container.appState.members) { members = $0 ?? [] }
```

再來把預覽結構 `ContentView_Previews` 內 `environment` 的 `DIContainer` 建立方式改一下：
```swift
.environment(\.injected, DIContainer(isMock: true))
```

把 `TestButton` 原本 `AppState` 改成 `Interactor`：
```swift
@ViewBuilder
private func TestButton() -> some View {
    Button("Test Push Members") {
        let random = Member(id: Int64.random(in: 1...Int64.max), name: UUID().uuidString, position: .Mid)
    
        _ = container.interactor.member.saveMember(random)
    }
    .buttonStyle(.borderedProminent)
}
```

稍微改一下顯示的內容：
```swift
@ViewBuilder
private func memberList() -> some View {
    VStack {
        if members.isEmpty {
            Text("Empty Member!")
        } else {
            ForEach(members, id: \.id) { member in
                Text("\(member.id)")
                    .lineLimit(1)
                Text("\(member.name)")
                    .lineLimit(1)
                Text("\(member.position.rawValue)")
                    .lineLimit(1)
            }
        }
    }
}
```

最後加上 `onAppear` 修飾器來取得所有 `Member`：
```swift
var body: some View {
    VStack {
        memberList()
        TestButton()
    }
    .onReceive(container.appState.members) { members = $0 ?? [] }
    .onAppear { container.interactor.member.getAllMember() }
}
```

> `onAppear` 修飾器會在 `View` 初始化後執行內部的內容

### 最後的 `ContentView` 長這樣：
```swift
import SwiftUI


struct ContentView: View {
    @Environment(\.injected) private var container: DIContainer
    @State private var members = [Member]()
    
    var body: some View {
        VStack {
            memberList()
            TestButton()
        }
        .onReceive(container.appState.members) { members = $0 ?? [] }
        .onAppear { container.interactor.member.getAllMember() }
    }
    
    @ViewBuilder
    private func memberList() -> some View {
        VStack {
            if members.isEmpty {
                Text("Empty Member!")
            } else {
                ForEach(members, id: \.id) { member in
                    Text("\(member.id)")
                        .lineLimit(1)
                    Text("\(member.name)")
                        .lineLimit(1)
                    Text("\(member.position.rawValue)")
                        .lineLimit(1)
                }
            }
        }
    }
    
    @ViewBuilder
    private func TestButton() -> some View {
        Button("Test Push Members") {
            let random = Member(id: Int64.random(in: 1...Int64.max), name: UUID().uuidString, position: .Mid)
        
            _ = container.interactor.member.saveMember(random)
        }
        .buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.injected, DIContainer(isMock: true))
    }
}
```

# BUG?
---
筆者在測試時，發現 `Member` 的 `Position` enum 定義為 `Int` 給 `SQLite` 辨認時似乎會有 BUG，一直讀不到。

改成 `Int64` 之後就好了：
```swift
enum Position: Int64 {
    case Top = 1, JG = 2, Mid = 3, ADC = 4, Support = 5
}

extension Position: Value {
    typealias Datatype = Int64
    
    static var declaredDatatype: String {
        Int64.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: Int64) -> Position {
        return Position(rawValue:datatypeValue) ?? .Support
    }
    
    var datatypeValue: Int64 {
        return self.rawValue
    }
}
```

# 按按看吧
---
點選 Xcode 上方的播放鍵來啟動模擬器：

![https://ithelp.ithome.com.tw/upload/images/20231009/20162383GYxoXzjHj0.png](https://ithelp.ithome.com.tw/upload/images/20231009/20162383GYxoXzjHj0.png)

按幾次按鈕後把這個 App 從背景滑掉，再重開 App 看看資料還在不在？

![https://ithelp.ithome.com.tw/upload/images/20231009/201623836zVwWoO2cS.png](https://ithelp.ithome.com.tw/upload/images/20231009/201623836zVwWoO2cS.png)

# 總結
---
本章實作 `Interactor`，並把 `AppState` `Repository` 傳入 `Interactor`。

利用 `DIContainer` 定義的 `isMock` 來定義資料庫是否是暫時的。

最後將 `ContentView` 中的按鈕，改為調用 `Interactor` 來執行資料的變更。