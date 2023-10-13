import Foundation
import Sworm

struct Dao: SQLiteDao {
    init(isMock: Bool) {
        let db = SQL.setup(dbName: "database", isMock: isMock)
        db.migrate([TodoEvent.self])
    }
}

extension Dao: Repository {}
