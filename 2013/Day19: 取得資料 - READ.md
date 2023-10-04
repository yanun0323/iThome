# SELECT
---
`prepare` 方法可以取得資料，`prepare` 方法及 SQL 的對照大概長這樣：
```swift
try db.prepare(tableMember)
// SELECT * FROM "members"
```

### WHERE
除了 `filter` 之外，`where` 也有同樣的效果：

> 以下省略 `try db.prepare()`
```swift
tableMember.where(name == "Faker")
// SELECT * FROM "members" 
// WHERE "name" = 'Faker'


tableMember.where([1, 2, 3].contains(id))
// SELECT * FROM "members" 
// WHERE "id" IN (1, 2, 3)

tableMember.where(name.like("%ake%"))
// SELECT * FROM "members" 
// WHERE "name" LIKE '%ake%'

tableMember.where(name == "Faker" && position == .Mid)
// SELECT * FROM "members" 
// WHERE "name" = 'Faker'
// AND "position" = 3

tableMember.where(name.lowercaseString == "faker" || position == .Mid)
// SELECT * FROM "members" 
// WHERE lower("name") = 'faker'
// OR "position" = 3

```

> `filter` 和 `where` 可以互換使用，他們只是別名，功能都一樣

### SELECT, ORDER, LIMIT
> 以下省略 `try db.prepare()`
```swift
tableMember
    .select(id, name)
    .where(name == "Faker")
    .order(id.desc)
    .limit(10)
// SELECT "id", "name" 
// FROM "members" 
// WHERE "name" = 'Faker'
// ORDER BY "id" DESC
// LIMIT 10
```

### 解析資料
`prepare` 取得的資料會是一個 `Row` 結構的陣列，需要遍歷每個元素來解析資料。

解析的方式要用 `Row` 的 `get` 方法：

```swift
let rows = try db.prepare(tableMember)

var members: [Member] = []

for row in rows {
    let id = try row.get(id)
    let name = try row.get(name)
    let position = try row.get(position)

    let member = Member(id: id, name: name, position: position)
    members.append(member)
}
```

### 實作 findMember 的方法在 SQLite.swift，來取得 Member：
```swift
func findMember(_ db: Connection, name target: String) -> [Member]? {
    do {
        let rows = try db.prepare(
            tableMember
                .select(id, name, position)
                .where(name == target)
                .order(id.asc)
        )
        
        var members: [Member] = []

        for row in rows {
            let id = try row.get(id)
            let name = try row.get(name)
            let position = try row.get(position)

            let member = Member(id: id, name: name, position: position)
            members.append(member)
        }
        
        return members
        
    } catch {
        print("find member name: \(target) error: \(error)")
    }
    
    return nil
}
```

# COUNT 或其他計量值
---
`scalar` 方法可以取得資料數量/計算值，`scalar` 方法及 SQL 的對照大概長這樣：
```swift
let count = try db.scalar(tableMember.count)
// SELECT count(*) 
// FROM "tableMember"
```

### 其他計算方法
> 以下省略 `try db.scalar()`
```swift
tableMember.where(name != "").count
// SELECT count(*) 
// FROM "tableMember" 
// WHERE "name" <> ""

tableMember.select(name.count) // -> Int
// SELECT count("name") 
// FROM "members"

tableMember.select(id.max) // -> Int64?
// SELECT max("id") 
// FROM "members"

tableMember.select(id.min) // -> Int64?
// SELECT min("id") 
// FROM "members"

tableMember.select(id.average) // -> Int64?
// SELECT avg("id") 
// FROM "members"

tableMember.select(id.sum) // -> Int64?
// SELECT sum("id") 
// FROM "members"

tableMember.select(id.total) // -> Int64
// SELECT total("id") 
// FROM "members"

tableMember.select(name.distinct.count) // -> Int
// SELECT count(DISTINCT "name") 
// FROM "members"
```

# 其他的你就要去看看文件啦
---
像 `Join` 或 `Iterate` 那些寫法就請去看官方文件啦！官方文件寫得很好，不怕看不懂！

# 參考資料
---

- [stephencelis/SQLite 官方文件](https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#sqliteswift-documentation)