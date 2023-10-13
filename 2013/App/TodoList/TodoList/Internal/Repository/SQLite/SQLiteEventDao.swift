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
