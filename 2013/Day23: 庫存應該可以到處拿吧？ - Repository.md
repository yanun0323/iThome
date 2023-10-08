這個章節要來實作 `Repository` 的程式碼。

# Repository
---
記得我們在 `Clean Architecture` 章節，定義了 `Repository` 這個 `Protocol` 的內容嗎？

```swift
protocol Repository: MemberRepository {}

protocol MemberRepository {
    func getMember(_ name: String?, _ position: Position?) throws -> [Member]
    func saveMember(_:Member) throws -> Member?
    func updateMember(_:Member) throws
    func deleteMember(_:Member) throws
}
```

# 實作 Dao
---
首先我們先新建一個 `Dao.swift` 並建立一個 `Dao` 結構。

這個結構會繼承 `Repository` 之後實作方法：

![https://ithelp.ithome.com.tw/upload/images/20231008/20162383dcVGiSZcZr.png](https://ithelp.ithome.com.tw/upload/images/20231008/20162383dcVGiSZcZr.png)

不過這樣寫我們可以預期，在未來方法變多了，就會很難管理對吧？

所以我習慣會把他們分開，再讓 `Dao` 繼承。

但由於這邊我想用 `struct` 來寫，所以額外的 `Dao` 分類就要用 `Protocol` 來實作。
什麼意思？實際寫寫看就知道了。

# SQLiteDao
---

首先我們在 `Repository` 資料夾內建立 `SQLite` 資料夾，在裡面新增 `SQLiteDao.swift`，並定義 `SQLiteDao` `Protocol`：

![https://ithelp.ithome.com.tw/upload/images/20231008/20162383d1pvyYR6QG.png](https://ithelp.ithome.com.tw/upload/images/20231008/20162383d1pvyYR6QG.png)

```swift
protocol SQLiteDao {}
```

# SQLiteMemberDao
---
接著在同樣 `SQLite` 資料夾裡新增 `SQLiteMemberDao.swift`，並定義 `SQLiteMemberDao` `Protocol`：

```swift
protocol SQLiteMemberDao {}
```

接下來利用 `where Self: {Protocol}` 並在 `SQLiteMemberDao` 內實作方法，這邊我們要實作 `MemberRepository`：

![https://ithelp.ithome.com.tw/upload/images/20231008/20162383FDpXUAMVEv.png](https://ithelp.ithome.com.tw/upload/images/20231008/20162383FDpXUAMVEv.png)

```swift
import Foundation
import Sworm
import SQLite

protocol SQLiteMemberDao {}

extension SQLiteMemberDao where Self: MemberRepository {
    func getMember(_ name: String?, _ position: Position?) throws -> [Member] {
        let rows = try SQL.getDriver().query(Member.self) { t in
            if let name = name, let position = position {
                return t.where(Member.name == name && Member.position == position)
            }
            
            if let name = name {
                return t.where(Member.name == name)
            }
            
            if let position = position {
                return t.where(Member.position == position)
            }
            
            return t
        }
        
        var result = [Member]()
        for row in rows {
            result.append(try Member.parse(row))
        }
        return result
    }
    
    func saveMember(_ member: Member) throws -> Member? {
        let id = try SQL.getDriver().insert(member)
        return Member(id: id, name: member.name, position: member.position)
    }
    
    func updateMember(_ member: Member) throws {
        let _ = try SQL.getDriver().update(member, where: Member.id == member.id)
    }
    
    func deleteMember(_ member: Member) throws {
        let _ = try SQL.getDriver().delete(Member.self) { $0.where(Member.id == member.id) }
    }
}
```

# 繼承 Protocol
---
方法都實作完了，接下來就要讓他全部繼承回 `Dao` 了！

首先先將 `SQLiteDao` 繼承 `SQLiteMemberDao`：
```swift
protocol SQLiteDao: SQLiteMemberDao {}
```

接下來再將 `Dao` 繼承 `SQLiteDao`：
```swift
struct Dao: SQLiteDao {}
```

接著會發現，就算 `Dao` 結構沒有實作 `Repository` 的方法，也不會噴錯：

![https://ithelp.ithome.com.tw/upload/images/20231008/201623836LqQbR2aWT.png](https://ithelp.ithome.com.tw/upload/images/20231008/201623836LqQbR2aWT.png)

這是因為，我們已經在 `SQLiteMemberDao` 內實作方法了。

接下來我們要在 `Dao` 的 `init` 方法內，連線到資料庫並建立 `Table`：

![https://ithelp.ithome.com.tw/upload/images/20231008/20162383XyOWonZQ41.png](https://ithelp.ithome.com.tw/upload/images/20231008/20162383XyOWonZQ41.png)

```swift
struct Dao: SQLiteDao {
    init() {
        let conn = SQL.setup(dbName: "database", isMock: false)
        conn.migrate([Member.self])
    }
}
```

這樣就大功告成了！

# 總結
---

我們使用 `Protocol` 來實作 `Repository` 內的方法。

這樣的優點是未來如果不想用 `SQLite`，想改成別的比方說 `MySQL`。

不用把外部使用的方法重寫，也不用把 `SQLiteDao` 整個重寫，只要再新寫一個 `MySQLDao` 就能達到抽換資料庫的目的，又可以降低對資料庫實作的耦合。
