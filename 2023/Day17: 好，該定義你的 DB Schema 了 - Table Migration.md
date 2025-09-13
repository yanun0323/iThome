要將資料儲存進資料庫，第一個步驟就是要定義存進資料庫的結構長怎樣。

# 建立 DB Schema
---
首先我們要為需要儲存的資料建立 `Table`。

> 例如我們有個 `Member` 結構如下

```swift
import Foundation

enum Position {
    case Top, JG, Mid, ADC, Support
}

struct Member {
    let id: Int64
    let name: String
    let position: Position
}
```

我們先新建一個 `SQL.swift` 檔案，並加上 `import SQLite`。
為了方便，本系列 `SQLite` 有關的程式碼都會先寫在這邊：

![https://ithelp.ithome.com.tw/upload/images/20231002/201623838A852cJYx1.png](https://ithelp.ithome.com.tw/upload/images/20231002/201623838A852cJYx1.png)

### 建立 Expression
`Expression` 可以讓我們更好的利用套件跟 `SQLite` 互動，首先我們要為這個 `Table` 的每個欄位建立 `Expression`，每個 `Expression` 也同時定義了該欄位的型別：

```swift
let id = Expression<Int64>("id")
let name = Expression<String>("name")
let position = Expression<Position>("position")
```
> 我們在 `SQLite.swift` 加上 `Member` 的三個欄位定義

![https://ithelp.ithome.com.tw/upload/images/20231002/20162383CByO0MoAnO.png](https://ithelp.ithome.com.tw/upload/images/20231002/20162383CByO0MoAnO.png)

> 畫面中左右分割畫面，可以點選紅圈處的按鈕叫出來

#### [`支援的型別可以透過官方文件查詢`](https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#building-type-safe-sql)

![https://ithelp.ithome.com.tw/upload/images/20231002/20162383SGCi948Mx6.png](https://ithelp.ithome.com.tw/upload/images/20231002/20162383SGCi948Mx6.png)

### 建立 Migration
定義完 `Expression` 之後就可以來寫建立 `Table` 的函式了。

首先我們要定義 `Table` 名稱，在 `SQLite.swift` 加上：

```swift
let tableMember = Table("members")
```

接著新增建立 `Table` 的函式：
> 這段程式碼會噴錯，解法請看下個段落
```swift
func createMemberTable(_ db: Connection) throws {
    try db.run(tableMember.create(ifNotExists: true) { t in
        t.column(id, primaryKey: .autoincrement)
        t.column(name, unique: true)
        t.column(position)
    })
    
    try db.run(tableMember.createIndex(name, ifNotExists: true))
}
```
這邊傳入 `SQLite` 的連線 `Connection`，使用來對資料庫進行操作。

利用定義的 `tableMember` 調用 `create` 方法來建立 `Table`，`t.column` 建立每一個欄位。

也可以利用 `createIndex` 來建立 `index`

以上程式碼等於下面的 `SQL`：
```sql
CREATE TABLE IF NOT EXISTS "members" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "name" TEXT UNIQUE NOT NULL,
    "position" INTEGER NOT NULL,
)

CREATE INDEX IF NOT EXISTS "index_members_on_name" ON "members" ("name")
```

### 自訂支援型別

上方程式碼會噴一個錯誤，原因是 `Position` 這個結構 `SQLite` 的型別不支援

![https://ithelp.ithome.com.tw/upload/images/20231002/201623835NAKZLpysQ.png](https://ithelp.ithome.com.tw/upload/images/20231002/201623835NAKZLpysQ.png)

所以我們要將 `Position` 實作 `Value` 這個 Protocol，來讓 `SQLite` 可以辨認他：
> 先將 `Member.swift` 加上 `import SQLite`
```swift
import SQLite
```

> 將 `Position` 改為以 `Int` 為 `rawValue`
```swift
enum Position: Int {
    case Top = 1, JG = 2, Mid = 3, ADC = 4, Support = 5
}
```

> 讓 `Position` 實作 `Value`
```swift
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
```
- `Datatype`：`Position` 要用哪種 `SQLite` 支援的型別儲存進資料庫內
- `declaredDatatype`：`SQLite` 支援型別的辨認字串，`SQLite` 支援的型別會有 `declaredDatatype` 這個 `static` 變數
- `fromDatatypeValue`：`SQLite` 儲存的型別轉換成 `Position`
- `datatypeValue`：`Position` 轉換成 `SQLite` 儲存的型別

上方定義完後，`SQLite` 就可以把 `Position` 轉換成 `Int` 儲存進 `SQLite` 裡了。

`createMemberTable` 這個函式也不會噴錯了。

### 執行 Migration
為了說明方便，我們直接在 `ContentView` 建立一個 `SQLite` 連線變數，接著在 `init` 內建立連線，並執行 `createMemberTable`
```swift
import SwiftUI
import SQLite

struct ContentView: SwiftUI.View {
    @State private var db: Connection
    
    init() {
        self.db = try! Connection(.inMemory)
        do {
            try createMemberTable(db)
        } catch {
            print(error)
            return
        }
        print("member table created")
    }
    
    var body: some SwiftUI.View {
        Text("Hello")
    }
}
```

`Connection(.inMemory)` 是連線到一個 `記憶體暫存資料庫`，若是軟體關閉，資料庫就會消失

如果要讓 `SQLite` 永久儲存在硬碟內，就要用 `Connection("database")` 就能將資料庫永久儲存了

# 總結
---

本章介紹如何定義、創建 `SQLite` `Table`，並實作 `Value` Protocol 來讓 `SQLite` 支援自訂的型別。

在 `Clean Architecture` 章節會介紹在哪個時機點創建 `Table`。


# 參考資料
---

- [stephencelis/SQLite 官方文件](https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#sqliteswift-documentation)