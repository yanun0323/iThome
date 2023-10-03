本章節會開始介紹 `SQLite` 套件如何執行 `CRUD`。

使用 `SQLite` 執行 `CREATE`、`UPDATE`、`DELETE` 來取得/更新/刪除資料。

這邊同樣以上一章的 `Member` 這個結構來示範：
```swift
struct Member {
    let id: Int64
    let name: String
    let position: Position
}
```

# CRUD
`SQLite` 套件中，所有的 `CRUD` 操作都是透過我們一開始定義的 `Table` 來作為開始點
> 記得上一章定義的 `tableMember` 嗎？

所以所有的 `CRUD` 都會長下面這樣：
```swift
try db.run(tableMember.{CRUD})
// 以 tableMember call 各種 CRUD 方法 
```

# CREATE
---
`insert` 方法可以新增資料，`insert` 方法及 `SQL` 的對照大概長這樣：

```swift
try db.run(tableMember.insert(name <- "Faker", position <- Position.Top))
// INSERT INTO "members" ("name", "position") VALUES ('Faker', 1)

try db.run(tableMember.insert(or: .replace, name <- "Faker", position <- Position.Top)))
// INSERT OR REPLACE INTO "members" ("name", "position") VALUES ('Faker', 1)
```

實作 `insertMember` 的方法在 `SQLite.swift`，來新增任何想要新增的 `Member`：
```swift
func insertMember(_ db: Connection, member: Member) -> Member? {
    do {
        let id = try db.run(
            tableMember
                .insert(
                    name <- member.name,
                    position <- member.position
                )
        )
        return Member(id: id, name: member.name, position: member.position)
    } catch {
        print("insert member \(member.name) error: \(error)")
    }
    return nil
}
```
> `insert` 之後會傳回新增的 row id，所以當成功新增資料之後，這個 function 回傳一個有塞過 id 值的 `Member`

之後調用 `insertMember` 方法就會把傳入的 `Member` 儲存進資料庫中，然後回傳在資料庫中相對應 id 的 `Member`。

# Transaction
`SQLite` 也提供 `transaction` 的方法：

```swift
try db.transaction {
    // try db.run( ... )
    // try db.run( ... )
    // ...
}
```

當 `transaction` 有任何 error 產生的時候，會自動 rollback

# UPDATE
---
`update` 方法可以更新資料，`update` 方法及 `SQL` 的對照大概長這樣：
```swift
try db.run(tableMember
    .filter(id == 1)
    .update(name <- "Faker")
)
// UPDATE "members" SET "name" = 'Faker' WHERE ("id" = 1)
```

### `.filter` 就像 `SQL` 語法中的 `WHERE`
在 `filter` 內加入判斷函式，就如同在 `SQL` 的 `WHERE` 之後加入篩選的值

實作 `updateMember` 的方法在 `SQLite.swift`，來更新任何想要更新的 `Member`：
```swift
func updateMember(_ db: Connection, member: Member) {
    do {
        let effectedRows = try db.run(
            tableMember
                .filter(id == member.id)
                .update(
                    name <- member.name,
                    position <- member.position
                )
        )
        print("updated \(effectedRows) rows")
    } catch {
        print("udpate member \(member.name) error: \(error)")
    }
}
```

# DELETE
---
`delete` 方法可以刪除資料，`update` 方法及 `SQL` 的對照大概長這樣：
```swift
try db.run(tableMember.delete())
// DELETE FROM "members"

try db.run(tableMember.filter(id == 1).delete())
// DELETE FROM "members" WHERE ("id" == 1)
```

實作 `deleteMember` 的方法在 `SQLite.swift`，來刪除任何想要刪除的 `Member`：
```swift
func deleteMember(_ db: Connection, member: Member) {
    do {
        let effectedRows = try db.run(
            tableMember
                .filter(id == member.id)
                .delete()
        )
        print("delete \(effectedRows) rows")
    } catch {
        print("delete member \(member.name) error: \(error)")
    }
}
```
# 總結
---

本章介紹了如何使用 `SQLite` 套件來執行 `INSERT`、`UPDATE`、`DELETE`。


# 參考資料
---

- [stephencelis/SQLite 官方文件](https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#sqliteswift-documentation)