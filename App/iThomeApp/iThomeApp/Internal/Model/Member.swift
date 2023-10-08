import Foundation
import SQLite
import Sworm

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
        try db.run(sqlTable.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(name, unique: true)
            t.column(position)
        })
        
        try db.run(sqlTable.createIndex(name, ifNotExists: true))
    }
    
    static func parse(_ row: Row) throws -> Member {
        let pID = try row.get(id)
        print("id \(pID)")
        let pName = try row.get(name)
        print("name \(pName)")
        let pPosition = try row.get(position)
        print("position: \(pPosition)")
        return Member(
            id: pID,
            name: pName,
            position: pPosition
        )
    }
    
    func setter() -> [Setter] {
        return [
            Member.id <- id,
            Member.name <- name,
            Member.position <- position
        ]
    }
}
