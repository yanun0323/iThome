前幾張我們學到了 `Text`、`VStack` ...

等等，那我們如果要寫很多 `Text`，難道要一個一個寫？

這時候就輪到我們的 `ForEach` 出場了！

# ForEach
---
`ForEach` 可以將一整坨資料 `Array`、`Dictionary` 做個別顯示。

比如說我們有下列資料：
```swift
var champion: [String] = ["Faker", "MaRin", "Bengi", "Bang", "Wolf", "kkOma"]
```

可以用以下方式顯示出來：
```swift
VStack {
    ForEach(champion, id: \.self) { member in
        Text("This is \(member)")
    }
}
```

![https://ithelp.ithome.com.tw/upload/images/20230922/20162383dP9reVDoeD.png](https://ithelp.ithome.com.tw/upload/images/20230922/20162383dP9reVDoeD.png)

> `Text` 可以用 `\()` 來將變數帶入到 `String` 中

這邊可以看到 `ForEach` 的參數要帶入要顯示的資料，這邊帶入 `champion` 很合理。

最後面的 `member` 是定義變數，代表 `champion` 內的每個成員。

比較難理解的是 `id` 。

`id` 代表 `ForEach` 要怎麼去辨識 `champion` 內的資料相不相同。

這裡的 `\.self` 代表要使用字串本身，如果今天你用的是其他結構，也可以用結構內的變數當作 `id`。

# Identifiable

`Identifiable` 是一個 `Protocol`。

`struct` 或 `class` 如果實作 `Identifiable`，那他就可以省略 `ForEach` 的 `id`。

例如我們不想用 String 當作 `champion` 的陣列內容，我們要定義一個新的 `Member` 結構來取代 String：
```swift
struct Member {
    var name: String
}
```

這邊我們試試加上 `Identifiable`：
```swift
struct Member: Identifiable {
    var name: String
}
```

在只加上 `Identifiable` 情況下會噴錯，因為 `Identifiable` 需要實作一個 `id` 變數。

可以按住 `Option` 點選 `Identifiable` 看他的說明。

![https://ithelp.ithome.com.tw/upload/images/20230922/20162383S74uBArNhg.png](https://ithelp.ithome.com.tw/upload/images/20230922/20162383S74uBArNhg.png)

於是我選擇 `UUID` 當作變數的型別：
```swift
struct Member: Identifiable {
    var id = UUID()
    var name: String
}
```

然後將剛剛的陣列改成這樣：
```swift
var champion: [Member] = [
    Member(name:"Faker"),
    Member(name:"MaRin"),
    Member(name:"Bengi"),
    Member(name:"Bang"),
    Member(name:"Wolf"),
    Member(name:"kkOma")
]
```

最後將 `ForEach` 改成這樣，這時就不用 `id` 了。
```swift
VStack {
    ForEach(champion) { member in
        Text("This is \(member.name)")
    }
}
```

![https://ithelp.ithome.com.tw/upload/images/20230922/20162383Sd1YudANyx.png](https://ithelp.ithome.com.tw/upload/images/20230922/20162383Sd1YudANyx.png)

# 總結
---
本章介紹了如何用 `ForEach` 來顯示資料，並用 `Identifiable` 來處理結構的 `id` 問題。 

只要有多筆資料要顯示，就會有 `ForEach` 的出現，`ForEach` 的一些進階的互動，就留在未來的章節討論。