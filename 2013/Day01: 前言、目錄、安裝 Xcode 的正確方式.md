# 前言
此系列帶你從一個 Golang 後端工程師的角度，逐步學習 SwiftUI 這個充滿蘋果美學的框架。並利用後端工程師熟悉的 SQLite 來建構資料庫，取代理解成本稍高的 Core Data。並使用 Clean Architecture (乾淨架構) 來建構層級分明的 App。

### 什麼是 SwiftUI
SwiftUI 是 Apple 在 2019 年全球開發者大會(WWDC) 發表的全新框架。利用宣告式語法來開發 App，讓程式語法更容易撰寫且理解。

> SwiftUI 寫出來的程式碼會長這樣，非常容易理解。
```swift
Text("Hello World")             // 文字
    .foregroundColor(.red)      // 改變文字前景顏色
    .font(.title)               // 設定文字大小
    .padding(10, .vertical)     // 設定文字邊距
```

### 看文章前你要知道
**這系列文章並不是寫給純新手的，在閱讀系列文章前你應該具備以下能力：**
- **熟悉 Mac 操作**
- **熟悉 Swift 語法 及 物件導向概念**
- **熟悉 SQL 語法 ( Day16 開始 )**
> 若是未接觸過 Swift，推薦使用 Apple 官方開發的 [**Swift Playground**](https://www.apple.com/tw/swift/playgrounds/) 來學習
>
> 若是未接觸過 SQL 語法，推薦使用 W3 Schools 的 [**SQL教學**](https://www.w3schools.com/sql/) 來學習

# 文章目錄
---

- ### 開發環境設定
    - Day01: 前言、目錄、安裝 Xcode 的正確方式
    - [Day02: Xcode 介面指南](https://ithelp.ithome.com.tw/articles/10320895)
- ### SwiftUI 元件指南
    **靜態元件**
    - [Day03: 一切畫面的基礎 - View、Preview Provider、Canvas](https://ithelp.ithome.com.tw/articles/10321525)
    - Day04: 放一些文字跟圖片吧 - Text、Image
    - Day05: 幫你的人生增添一點色彩 - Color、ForegroundColor
    - Day06: 什麼？上下左右？ - VStack, HStack, ZStack, Background, Overlay
    - Day07: 資料排排站 - ForEach, Identifiable
    - Day08: 等等，你的程式碼有點亂喔 - ViewBuilder, Extension

    **動態元件**
    - Day09: 畫面資料怎麼改呢 - Combine, State, StateObject, ObservedObject
    - Day10: 放一顆按鈕試試？ - Button
    - Day11: 來選擇障礙一下吧 - Picker, Menu
    - Day12: 我的畫面，沒有盡頭！ - ScrollView, List, TabView
    - Day13: 有時候得彈出一點東西 - Alert, PopupSheet
    - Day14: 層層疊疊的樹狀分頁 - NavigationStack
    - Day15: 用滑動做一點事 - Gesture
- ### SQLite
    - Day16: 後端工程師的好朋友 - SQLite
    - Day17: 好，該定義你的 DB Schema 了 - Table Migration
    - Day18: 要一些資料、刪掉一些資料 - GET, DELETE
    - Day19: 塞一些資料、更新一些資料 - INSERT, UPDATE
    - Day20: 沒有，我只是想推銷一下自己寫的 Package - Sworm
- ### Clean Architecture 
    - Day21: 哇！這是什麼鬼架構？ - Architecture
    - Day22: 狀態夏令營 - AppState
    - Day23: 業務邏輯就只能是邏輯 - Interactor
    - Day24: 庫存應該可以到處拿吧？ - Repository
    - Day25: 不是，我只是想推銷一下自己寫的 Package - Ditto
- ### 來試試開發 APP 吧
    - Day26: 先等等！你的APP想長怎樣？ - Concept View
    - Day27: 好的！那你的資料怎麼跑？ - Data Flow Design
    - Day28: 開始動手吧，寫程式囉 - Repository, Interactor, AppState
    - Day29: 剛剛的畫面呢？拿來用吧 - View, Refactor
    - Day30: 噢！這是我寫的 APP！

# 安裝 Xcode 的正確方式
---
[**Xcode**](https://developer.apple.com/xcode/) 是 Apple 開發，專門開發 Apple 裝置軟體的 IDE。

一般最簡單的方法就是透過 AppStore 下載。但 AppStore 下載有諸多缺點：
- 下載過程中，Xcode 不能使用
- 有新版時會一直要你更新
- 只能安裝一種版本的 Xcode
- 沒有 Beta 版本

因此我建議用下面兩種做法來安裝 Xcode：

### 1. [developer.apple.com](https://developer.apple.com/download/all/)
官方的 developer 網站會有所有的 Xcode 歷史版本可以下載，不過這個方式的缺點是 Xcode 版本管理要自己來。
> developer.apple.com
![https://ithelp.ithome.com.tw/upload/images/20230916/20162383alLcj5ChIv.png](https://ithelp.ithome.com.tw/upload/images/20230916/20162383alLcj5ChIv.png)


### 2. [Xcodes]((https://www.xcodes.app))
筆者目前都用這個開源軟體。他可以很有效的管理 Xcode 的版本，也可以選擇檢視 Release/Beta 版本，也可以用更快的方法做下載驗證。

> Xcodes 介面
![https://ithelp.ithome.com.tw/upload/images/20230916/20162383Ild7Dce0Xe.png](https://ithelp.ithome.com.tw/upload/images/20230916/20162383Ild7Dce0Xe.png)

可以直接用 homebrew 下載
```bash
$ brew install xcodes
```

以上就是安裝 Xcode 的正確方式，下一篇會帶你看一遍 Xcode 的介面，並介紹一些開發上要注意的事。

## 參考資料
[13大 - 下載 Xcode 的正確姿勢](https://ethanhuang13.gitbook.io/wikipitia/xcode-pitfalls/download-xcode)