import Foundation
import SQLite
import Sworm

struct TodoEvent {
    var id: Int64
    var title: String
    var createAt: Date
    var complete: Bool
}

extension TodoEvent: Migrator {
    static var table: Tablex { Tablex("events") }
    
    static let id = Expression<Int64>("id")
    static let title = Expression<String>("title")
    static let createAt = Expression<Date>("create_at")
    static let complete = Expression<Bool>("complete")
    
    static func migrate(_ db: Connection) throws {
        try db.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(title)
            t.column(createAt)
            t.column(complete)
        })
    }
    
    static func parse(_ row: Row) throws -> TodoEvent {
        return TodoEvent(
            id: try row.get(id),
            title: try row.get(title),
            createAt: try row.get(createAt),
            complete: try row.get(complete)
        )
    }
    
    func setter() -> [Setter] {
        return [
            TodoEvent.title <- title,
            TodoEvent.createAt <- createAt,
            TodoEvent.complete <- complete
        ]
    }
}
