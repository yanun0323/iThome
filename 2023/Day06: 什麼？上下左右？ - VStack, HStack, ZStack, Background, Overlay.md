前幾章我們提到的元件，都是以單個元件出現的，如果放了兩個就會出現不是我們預期的結果，像下圖這樣。

![https://ithelp.ithome.com.tw/upload/images/20230921/20162383Rw3FXGtJto.png](https://ithelp.ithome.com.tw/upload/images/20230921/20162383Rw3FXGtJto.png)

> 文字及圖片分別變成兩個預覽畫面了

那我們該如何在同一個 `View ` 放多個元件？

# 垂直、水平排列
---
`SwiftUI` 提供兩個基本的平面排列方式：`VStack` 和 `HStack`
## VStack
可以讓內部的元件**垂直排列**，先寫的元件會排在上面。

```swift
VStack(alignment: .center, spacing: 15) {
    Text("Faker! What was that!")
    Image("Faker")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100)
}
```

![https://ithelp.ithome.com.tw/upload/images/20230921/20162383hC7StwsoPG.png](https://ithelp.ithome.com.tw/upload/images/20230921/20162383hC7StwsoPG.png)

> `alignment` 決定內部元件要怎麼對齊
>
> `spacing` 決定內部元件的間距

**值得注意的是 `VStack` 內部只能放十個元件，超過十個會報錯**

**這時候只要再包一層 `VStack` 就可以了**

## HStack

可以讓內部的元件**水平排列**，先寫的元件會排在左邊。

```swift
HStack(alignment: .center, spacing: 15) {
    Text("Faker! What was that!")
    Image("Faker")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100)
}
```

![https://ithelp.ithome.com.tw/upload/images/20230921/201623837muGAC5UU8.png](https://ithelp.ithome.com.tw/upload/images/20230921/201623837muGAC5UU8.png)

**`HStack` 也一樣有十個元件的限制**

# 前後排列
---
還有另外三個具有深度排列屬性的元件/修飾器：`ZStack`、`Background`、`Overlay`
## ZStack
可以讓內部元件**前後排列**，先寫的元件會排在後方。

```swift
ZStack {
    Text("Faker! What was that!")
    Image("Faker")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 100)
}
```

![https://ithelp.ithome.com.tw/upload/images/20230921/20162383cXvTxSb3SP.png](https://ithelp.ithome.com.tw/upload/images/20230921/20162383cXvTxSb3SP.png)

> 上方程式碼因為 `Text` 先寫了，所以會排在後方
>
> `Image` 寫在 `Text` 之後，所以會在 `Text` 的前方

## Background
`Background` 是一個修飾器，放在裡面的元件都會被放在該 `View` 的**後方**。

```swift
Text("Faker! What was that!")
    .background {
        Image("Faker")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100)
    }
```

![https://ithelp.ithome.com.tw/upload/images/20230921/20162383wIVRmyFzAE.png](https://ithelp.ithome.com.tw/upload/images/20230921/20162383wIVRmyFzAE.png)

> 可以看到 `Image` 現在在 `Text` 的後方
>
> 而且 `Image` 因為是 `Text` 的 `Background`，所以他的大小會根據 `Text` 改變

## Overlay
`Overlay` 是一個修飾器，放在裡面的元件都會被放在該 `View` 的**前方**。

```swift
Text("Faker! What was that!")
    .overlay {
        Image("Faker")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100)
    }
```
> 可以看到 `Image` 現在在 `Text` 的前方
>
> 而且 `Image` 因為是 `Text` 的 `Overlay`，所以他的大小會根據 `Text` 改變

![https://ithelp.ithome.com.tw/upload/images/20230921/20162383CWFsKlS6Zm.png](https://ithelp.ithome.com.tw/upload/images/20230921/20162383CWFsKlS6Zm.png)

# 總結
---

這部分的元件有很多種搭配方式，比如 `Background` 搭配 `Color` 可以做出底色。

其他更多搭配可以自己玩玩看！