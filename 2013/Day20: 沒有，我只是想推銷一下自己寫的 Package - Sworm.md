本章要來推銷一下自己寫的套件：[**Sworm**](https://github.com/yanun0323/Sworm)。

`Sworm` 將 `SQLite` 這個套件 `Wrap` 了一層，讓使用上更加容易。
# 擴充支援型別
---
`Sworm` 裡實作了 `SQLite` 對於 `Decimal`、`Color` 兩個型別的支援，不用再自己額外寫了！

# Migrator
---
`Migrator` 是一個 Protocol，將結構解析的邏輯都強迫封裝在一個 Protocol 內，方便管理每個結構的內容。他需要實作：
- **table 靜態屬性**：定義 `SQLite.Table`，型別是包裝過一層的 `Tablex`
- **migrate 靜態方法**：定義 `Create Table` 的內容，傳入 `SQLite.Connection`
- **parse 靜態方法**：定義解析資料的內容，傳入 `SQLite.Row`
- **setter 方法**：`insert`, `update`, `upsert` 的快速執行內容

以 `Member` 為例：
```swift
import Sworm

extension Member: Migrator {
    static private let sqlTable = Tablex("members")
    static var table: Tablex { return sqlTable }
    
    // Expression 也定義成 Member 靜態屬性
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
```

# SQL
---
`Sworm` 將所有 `SQLite` 的函式都封裝在 `SQL` 這個行為裡。

### 連線與 Migration
`SQL` 提供 `setup` 方法來連線到資料庫，`isMock` 參數來決定此資料庫是不是 in memory 的。

連線到資料庫後的 `migrate` 方法，可以將有實作 `Migrator` 的結構傳入，執行該結構內的實作的 `migrate` 方法。

以 `Member` 為例：

```swift
func setup() {
    let db = SQL.setup(dbName: "database", isMock: false)
    db.migrate([Member.self])
}
```

### CRUD
`SQL` 在 `Migrator` 的基礎上，提供各種方法來執行 CRUD：
```swift
// read
func findMembers() throws -> [Member] {
    let result = try SQL.getDriver().query(Member.self) {
        $0.where(Record.id == id) 
    }

    var members: [Member] = []
    for r in results {
        members.append(try Member.parse(r))
    }
    return members
}

// create
func createMember(_ elem: Member) throws -> Int64 {
    return try SQL.getDriver().insert(elem)
}

// update
func updateMember(_ elem: Member) throws -> Int {
    return try SQL.getDriver().update(elem, where: Member.id == r.id)
}

// upsert
func upsertMember(_ elem: Member) throws -> Int64 {
    return try SQL.getDriver().upsert(elem, Member.id, where: Member.id == r.id)
}

// delete
func deleteMember(_ id: Int64) throws -> Int {
    return try SQL.getDriver().run(Member.table.filter(Member.id == id).delete())
}
```

# 參考資料
---
- [我寫得算完整的README](https://github.com/yanun0323/Sworm/blob/master/README.md)
