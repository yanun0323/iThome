import Foundation
import Sworm

struct Dao: SQLiteDao {
    init(isMock: Bool) {
        let conn = SQL.setup(dbName: "database", isMock: isMock)
        conn.migrate([Member.self])
    }
}

extension Dao: Repository {}

