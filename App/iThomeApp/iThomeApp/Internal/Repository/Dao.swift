import Foundation
import Sworm

struct Dao: SQLiteDao {
    init() {
        let conn = SQL.setup(dbName: "database", isMock: false)
        conn.migrate([Member.self])
    }
}

extension Dao: Repository {}

