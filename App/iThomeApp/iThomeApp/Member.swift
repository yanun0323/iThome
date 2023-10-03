import Foundation
import SQLite

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
