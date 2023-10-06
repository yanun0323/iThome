import Foundation
import SQLite
import Sworm

enum Position: Int {
    case Top = 1, JG = 2, Mid = 3, ADC = 4, Support = 5
}

extension Position: Value {
    typealias Datatype = Int
    
    static var declaredDatatype: String {
        Int.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: Int) -> Position {
        return Position(rawValue: datatypeValue) ?? .Support
    }
    
    var datatypeValue: Int {
        return self.rawValue
    }
}

struct Member {
    let id: Int64
    let name: String
    let position: Position
}

extension Member: Migrator {
    static private let sqlTable = Tablex("members")
    static var table: Tablex { return sqlTable }
    
    static let id = Expression<Int64>("id")
    static let name = Expression<String>("name")
    static let position = Expression<Position>("position")
    
    static func migrate(_ db: Connection) throws {
        try db.run(tableMember.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(name, unique: true)
            t.column(position)
        })
        
        try db.run(tableMember.createIndex(name, ifNotExists: true))

    }
    
    static func parse(_ row: Row) throws -> Member {
        return Member(
            id: try row.get(id),
            name: try row.get(name),
            position: try row.get(position)
        )
    }
    
    func setter() -> [Setter] {
        return [
            Member.id <- self.id,
            Member.name <- self.name,
            Member.position <- self.position
        ]
    }
}
