# SQL
---
`SQL`（`Structured Query Language`，結構化查詢語言）是一種特定目的程式語言。用來和資料庫互動，做到 拿取 / 更新 / 刪除 資料庫內的資料。

常見使用 `SQL` 語言的 `關聯式資料庫（RDSMS）` 有 `MySQL`、`PostgreSQL`、`SQLite`。

如果你還不會 `SQL`，可以使用 W3 Schools 的 [**SQL教學**](https://www.w3schools.com/sql/) 來學習。

# SQLite
---
`SQLite` 是一個輕量化的 `關聯式資料庫` ，和其他 `關聯式資料庫` 不同的地方在於，他不是一個 `伺服器`，而是作為一個 `Library` 連結到程式中，並成為程式的一個組成部分。

本系列會以 [**stephencelis/SQLite**](https://github.com/stephencelis/SQLite.swift) 這個套件來和 `SQLite` 互動。

# 使用套件 Package
---
打開你的專案，並到 Xcode 頂部功能表選擇：`File` > `Add Packages...`

在右上角的搜尋區貼上這個 `SQLite` 套件的 github 網址

> https://github.com/stephencelis/SQLite.swift

![https://ithelp.ithome.com.tw/upload/images/20231001/20162383ItdqWdriMi.png](https://ithelp.ithome.com.tw/upload/images/20231001/20162383ItdqWdriMi.png)

然後按下右下角的 `Add Package`，加入套件。

接著在要使用這個 `Package` 的地方 `import` 就可以開始寫程式：
```swift
import SQLite
```

### `View` 的錯誤訊息

如果同時使用 `SwiftUI` 和 `SQLite` 套件，`View` 會噴錯。

![https://ithelp.ithome.com.tw/upload/images/20231001/20162383gMNC5dehRw.png](https://ithelp.ithome.com.tw/upload/images/20231001/20162383gMNC5dehRw.png)

因為 `SwiftUI` 和 `SQLite` 同時都有 `View` 這個關鍵字，Xcode 會不知道你要使用的是哪一個 `View`。下面提供兩個解法：
1. 不要同時使用 `SwiftUI` 和 `SQLite`
2. 在 `View` 之前增加套件名稱，例如 `SwiftUI.View`：

![https://ithelp.ithome.com.tw/upload/images/20231001/20162383E6FMcLPuuY.png](https://ithelp.ithome.com.tw/upload/images/20231001/20162383E6FMcLPuuY.png)

加入套件後我們就可以開始使用 `SQLite` 了！