本章會介紹我們常見到的上下/左右滑動的捲軸類 `View`。

有捲軸、列表、卡片。

# ScrollView
---

`ScrollView` 是 `SwiftUI` 提供的捲軸類 `View`。

![https://ithelp.ithome.com.tw/upload/images/20230927/20162383EHt6PE5F4T.png](https://ithelp.ithome.com.tw/upload/images/20230927/20162383EHt6PE5F4T.png)

```swift
ScrollView(.vertical, showsIndicators: true) {
    ForEach(1...100, id: \.self) { number in
        HStack {
            Spacer()
            Text("\(number)")
                .font(.largeTitle)
            Spacer()
        }
    }
}
```

> 可以試試看對著 `Canvas` 按住滑鼠上下滑動

**ScrollView(*_ axes: showsIndicators: content:*)**
- axes 提供 .vertical, .horizontal 兩個方向的 `ScrollView`
- showsIndicators 定義是否要顯示捲軸桿 
- content 定義要顯示的 `View` 內容

> 這邊 `HStack` 內的 `Spacer` 提供一個空白的擴張元素，他會根據 `Stack` 的方向擴展，這邊用來讓 `Text` 左右擴展到螢幕邊邊。

`ScrollView` 只有提供檢視的部分，如果需要用到左滑/右滑動作會需要用到 `List`。

# List
---

`List` 除了提供捲軸式介面之外，還提供左滑右滑動作：

![https://ithelp.ithome.com.tw/upload/images/20230927/20162383nJwCfZOWzj.png](https://ithelp.ithome.com.tw/upload/images/20230927/20162383nJwCfZOWzj.png)

我們顯示以下資料：
```swift
private let champion: [String] = ["Faker", "MaRin", "Bengi", "Bang", "Wolf", "kkOma"]
```

```swift
List {
    ForEach(champion, id: \.self) { member in
        Text(member)
    }
    .swipeActions(edge: .leading, allowsFullSwipe: false) {
        Button {
            print("right swipe action")
        } label: {
            Image(systemName: "archivebox.fill")
        }

    }
    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
        Button(role: .destructive) {
            print("left swipt action")
        } label: {
            Image(systemName: "trash.fill")
        }

    }
}
.listStyle(.inset)
```

> 可以試試看對著 `Canvas` 的 `List` 按住滑鼠上下滑動
>
> 或是對著 `List` 內的每一列左滑/右滑試試看

- `.listStyle` 修飾器可以改變 `List` 樣式
- `.swipeAction` 修飾器可以為 `List` 的每一行增加左滑/右滑動作
    - edge：左滑 or 右滑
    - allowFullSwipe：往左/往右滑到底就會觸發左滑/右滑動作
    - content：放 `Button`，建議用 `Label` 或 `Image`（systemImage）

# TabView
---

`TabView` 套用過 `.tabViewStyle` 的 `page` 樣式，提供類似 iPhone 主畫面的左右滑選項：

![https://ithelp.ithome.com.tw/upload/images/20230927/20162383enj71PryCp.png](https://ithelp.ithome.com.tw/upload/images/20230927/20162383enj71PryCp.png)

```swift
TabView {
    ForEach(champion, id: \.self) { member in
        Text(member)
            .foregroundColor(.white)
    }
}
.tabViewStyle(.page(indexDisplayMode: .always))
.background(Color.black)
```

> 可以試試看對著 `Canvas` 按住滑鼠左右滑動

# 總結
---
捲軸類的 `View` 在現代的 APP 設計中是不可或缺的角色。

今天介紹的三種捲軸類的 `View`，都可以在 `ForEach` 內自己設計每一個資料要怎麼顯示。

發揮你的設計魂玩玩看吧。
