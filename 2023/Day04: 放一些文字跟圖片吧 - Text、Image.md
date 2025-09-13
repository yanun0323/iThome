# 文字
`SwiftUI` 內提供一個文字元件 `Text` 來顯示文字，讓我們來放一些文字進我們的 `View` 吧！

```swift
Text("Faker! What was that?")
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383pUlOdR1bj6.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383pUlOdR1bj6.png)

## 文字樣式、大小、字體
`Text` 元件提供一些修改文字樣式的修飾器：
- `.font`: 文字的大小
- `.fontWeight`: 文字的粗細
- `.fontDesign`: 文字的樣式
```swift
Text("Faker! What was that?")
    .font(.title)
    .fontWeight(.medium)
    .fontDesign(.rounded)
```

![https://ithelp.ithome.com.tw/upload/images/20230919/2016238372dowJRrqX.png](https://ithelp.ithome.com.tw/upload/images/20230919/2016238372dowJRrqX.png)

上面三種修飾器也可以合併成以下兩種寫法：
```swift
Text("Faker! What was that?")
    .font(.system(.title, design: .rounded, weight: .medium))

Text("Faker! What was that?")
    .font(.system(size: 28, weight: .medium, design: .rounded))
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383rmCS8PRt3A.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383rmCS8PRt3A.png)

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383lvCFi0ORmK.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383lvCFi0ORmK.png)

## 多行文字
多行文字也會遇到很多需要處理的問題。

比如文字間距、行距，行數限制、文字刪減 ...... 等等。

這些問題都會有相對應的修飾器可以解決。

### 間距、行距
- `.kerning`: 文字的間距
- `.lineSpacing`: 文字的行距
```swift
Text("Faker! What was that? Arguably the most iconic 1v1 play and casting moment in League of Legends history. Featuring Faker, considered by most to be the best LoL player of all time, as well as casters DoA and MonteCristo, veteran casters of the LCK.")
    .kerning(2)
    .lineSpacing(5)
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383S0GVIl3uaO.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383S0GVIl3uaO.png)

### 行數限制
- `.lineLimit`: 行數限制
```swift
Text("Faker! What was that? Arguably the most iconic 1v1 play and casting moment in League of Legends history. Featuring Faker, considered by most to be the best LoL player of all time, as well as casters DoA and MonteCristo, veteran casters of the LCK.")
    .lineLimit(1)
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383VkbZ8hmhcE.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383VkbZ8hmhcE.png)

### 文字省略
因為行數限制會把多餘的文字省略掉，這邊就可以決定要從頭、尾還是中間省略文字
- `.truncationMode`: 文字的省略
```swift
Text("Faker! What was that? Arguably the most iconic 1v1 play and casting moment in League of Legends history. Featuring Faker, considered by most to be the best LoL player of all time, as well as casters DoA and MonteCristo, veteran casters of the LCK.")
    .lineLimit(1)
    .truncationMode(.middle)
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383XUryq6lLTE.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383XUryq6lLTE.png)

> `truncationMode` 的參數有 `.head`、`.middle` 和 `.tail`，可以自己玩玩看。

# 圖片
`SwiftUI` 內提供另一個元件 `Image` 來顯示圖片。

## 系統圖片
`SwiftUI` 內建有許多好看的系統 Icon。

> 可以點選右上角的 `+`，或用快捷鍵 `cmd + shift + L` 打開瀏覽

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383SZcXgUfXbB.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383SZcXgUfXbB.png)

> 內建很多 Icon，也會顯示他們的名稱。圖片中的名稱是 `square.and.arrow.up`

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383eAScX8gmbB.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383eAScX8gmbB.png)

我這邊選擇 `square.and.arrow.up` 這個 Icon 名稱，在 `ContentView` 中加入以下程式碼：
```swift
Image(systemName: "square.and.arrow.up")
```

![https://ithelp.ithome.com.tw/upload/images/20230919/201623832H8Ahhe2de.png](https://ithelp.ithome.com.tw/upload/images/20230919/201623832H8Ahhe2de.png)

## 外部資源圖片
如果要放自己的圖片，需要在 `Assets.xcassets` 這裡放進要顯示的圖：

> 先在 `Assets.xcassets` 內新建 `Image Set`

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383M3ERpnfZvb.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383M3ERpnfZvb.png)

> 取好名稱（我這邊取名 `Faker`），然後將你要的圖片放進去（點一下放圖片的框框再選取圖片即可）

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383JZDHsmV3Me.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383JZDHsmV3Me.png)

> 接著在 `ContentView` 中加入 `Image("")`，引號內放你剛剛取名的圖片名稱
```swift
Image("Faker")
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383vJplLn0qCB.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383vJplLn0qCB.png)

## 變更圖片大小
如果是自己的圖片，是沒辦法改變大小的。這時候就需要 `resizable` 修飾器，來讓圖片可以被改變。
```swift
Image("Faker")
    .resizable()
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383hGwPHwvzRu.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383hGwPHwvzRu.png)

不過這邊會發生一個問題是，圖片比例跑掉了。我們可以用 `aspectRatio` 修飾器來維持圖片的長寬比。
```swift
Image("Faker")
    .resizable()
    .aspectRatio(contentMode: .fill)
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383TuRj0Q64a6.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383TuRj0Q64a6.png)

> `aspectRatio` 的參數有 `.fit` 和 `.fill`，可以自己玩玩看。

接著就可以用 `frame` 修飾器來調整圖片大小了。
```swift
.frame(width: 300, height: 300)
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383iYtfUwMPoo.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383iYtfUwMPoo.png)

或是用 `ignoresSafeArea` 修飾器來讓圖片滿版。
```swift
.ignoresSafeArea()
```

![https://ithelp.ithome.com.tw/upload/images/20230919/20162383BHTuC4rl8K.png](https://ithelp.ithome.com.tw/upload/images/20230919/20162383BHTuC4rl8K.png)

# 總結

文字、圖片這邊只有提到基本的用法，還有很多修飾器可以玩。

你可以多試試用 `.` 去找找看還有什麼修飾器可以玩。

未來的章節也會提到其他可以使用在文字、圖片的修飾器。