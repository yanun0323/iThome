本章要介紹常用的手勢，點擊、拖曳、旋轉、縮放。

好的手勢設計可以幫助使用者在使用軟體上可以更快速直覺。

# Gesture
---

使用 `.gesture` 修飾器可以替 `View` 加上各式各樣的手勢功能。

```swift
.gesture (
    // 在這邊加入手勢
)
```

以下介紹的 `Gesture` 都是要寫在 `.gesture` 內才會生效的。

# TapGesture
---
`TapGesture` 可以辨識點擊手勢，並可以自訂點擊次數。比方說設定兩次點擊，達到雙擊才會有效果。

![https://ithelp.ithome.com.tw/upload/images/20230930/20162383bQAH8gHizs.png](https://ithelp.ithome.com.tw/upload/images/20230930/20162383bQAH8gHizs.png)

```swift
struct ContentView: View {
    @State private var scale: Bool = false
    
    var body: some View {
        Image(systemName: "iphone")
            .font(.system(size: 150))
            .scaleEffect(scale ? 2 : 1)
            .gesture(
                TapGesture(count: 2)
                    .onEnded { _ in
                        withAnimation {
                            scale.toggle()
                        }
                    }
            )
    }
}
```
- `.scaleEffect` 修飾器可以改變 `View` 的縮放
> `withAnimation` 可以讓 `SwiftUI` 監聽根據傳入的變數變化，自動產生動畫

`TapGesture` 可以設定 count，這邊設定 `2` 來達到雙點擊的效果。

`.onEnded` 來執行當 `TapGesture` 被觸發後的行為。

> 試試看雙擊 `Canvas` 內的 `iPhone` 圖示

# LongPressGesture
---
`LongPressGesture` 可以辨識長按手勢，並可以設定長按的時間及可移動距離。

![https://ithelp.ithome.com.tw/upload/images/20230930/20162383pzsKJdM6qp.png](https://ithelp.ithome.com.tw/upload/images/20230930/20162383pzsKJdM6qp.png)

```swift
struct ContentView: View {
    @State private var scale: Bool = false
    
    var body: some View {
        Image(systemName: "iphone")
            .font(.system(size: 150))
            .scaleEffect(scale ? 2 : 1)
            .gesture(
                LongPressGesture(minimumDuration: 0.5, maximumDistance: 15)
                    .onEnded { _ in
                        withAnimation {
                            scale.toggle()
                        }
                    }
            )
    }
}
```
- `minimumDuration` 設定長按觸發的時間，單位是秒
- `maximumDistance` 設定長按判斷時，手指容許的位移距離

> 試試看長按 `Canvas` 內的 `iPhone` 圖示

# RotateGesture
---
`RotateGesture` 可以辨識旋轉手勢，並可以設定最小觸發的旋轉角度。

![https://ithelp.ithome.com.tw/upload/images/20230930/20162383nq5L3uoqxB.png](https://ithelp.ithome.com.tw/upload/images/20230930/20162383nq5L3uoqxB.png)

```swift
struct ContentView: View {
    @State private var rotatedAngle: Angle = .zero
    
    var body: some View {
        Image(systemName: "iphone")
            .font(.system(size: 150))
            .rotationEffect(rotatedAngle)
            .gesture(
                RotationGesture(minimumAngleDelta: .zero)
                    .onChanged { angle in
                        rotatedAngle = angle
                    }
            )
    }
}
```
- `minimumAngleDelta` 當旋轉值超過此設定量，才會執行程式碼

這裡不用 `withAnimation`，想想看為什麼？加上 `withAnimation` 看看有什麼反應？

> 試試看旋轉 `Canvas` 內的 `iPhone` 圖示

#### `要在 Canvas 使用旋轉，可以按住 Option 鍵，再點擊 Canvas`

旋轉的時候會發現，每次旋轉，圖示會又重新歸零再旋轉一次。

這是因為我們沒有把上次旋轉值儲存下來。試試看這樣寫：

![https://ithelp.ithome.com.tw/upload/images/20230930/20162383ZEmFyD3qa4.png](https://ithelp.ithome.com.tw/upload/images/20230930/20162383ZEmFyD3qa4.png)

```swift
struct ContentView: View {
    @State private var changedRotatedAngle: Angle = .zero
    @State private var endedRotatedAngle: Angle = .zero
    
    var body: some View {
        Image(systemName: "iphone")
            .font(.system(size: 150))
            .rotationEffect(changedRotatedAngle)
            .rotationEffect(endedRotatedAngle)
            .gesture(
                RotationGesture(minimumAngleDelta: .zero)
                    .onChanged { angle in
                        changedRotatedAngle = angle
                    }
                    .onEnded { angle in
                        changedRotatedAngle = .zero
                        endedRotatedAngle += angle
                    }
            )
    }
}
```

我們儲存一個 `endedRotatedAngle` 當作變更後的旋轉值。

`changedRotatedAngle` 當作每次旋轉的旋轉值。

在 `.onEnded` 的時候將 `changedRotatedAngle` 的變量儲存進 `endedRotatedAngle`，再將 `changedRotatedAngle` 清空。

### `.onChanged` 與 `.onEnded` 的差異

- `.onChanged` 是當 `每次手指有變化時`，就會執行程式碼
- `.onEnded` 則是當 `手指變化結束後`，才會執行程式碼

# MagnificationGesture
---
`MagnificationGesture` 可以辨識縮放手勢，並可以設定最小觸發的縮放。

![https://ithelp.ithome.com.tw/upload/images/20230930/20162383mmv68yr1nV.png](https://ithelp.ithome.com.tw/upload/images/20230930/20162383mmv68yr1nV.png)

```swift
struct ContentView: View {
    @State private var changedScale: CGFloat = 1
    @State private var endedScale: CGFloat = 1
    
    var body: some View {
        Image(systemName: "iphone")
            .font(.system(size: 150))
            .scaleEffect(changedScale)
            .scaleEffect(endedScale)
            .gesture(
                MagnificationGesture(minimumScaleDelta: .zero)
                    .onChanged { value in
                        changedScale = value
                    }
                    .onEnded { value in
                        endedScale *= value
                        changedScale = 1
                    }
            )
    }
}
```

- `minimumAngleDelta` 當縮放值超過此設定量，才會執行程式碼

> 試試看縮放 `Canvas` 內的 `iPhone` 圖示

#### `要在 Canvas 使用縮放，可以按住 Option 鍵，再點擊 Canvas`


# DragGesture
---
`DragGesture` 可以辨識拖曳手勢，並可以設定最小觸發的拖曳距離。

![https://ithelp.ithome.com.tw/upload/images/20230930/20162383g0jDTkZP35.png](https://ithelp.ithome.com.tw/upload/images/20230930/20162383g0jDTkZP35.png)

```swift
struct ContentView: View {
    @State private var changedOffset: CGSize = .zero
    @State private var endedOffset: CGSize = .zero
    
    var body: some View {
        Image(systemName: "iphone")
            .font(.system(size: 150))
            .offset(changedOffset)
            .offset(endedOffset)
            .gesture(
                DragGesture(minimumDistance: .zero, coordinateSpace: .global)
                    .onChanged { value in
                        changedOffset.width = value.translation.width
                        changedOffset.height = value.translation.height
                    }
                    .onEnded { value in
                        endedOffset.width += changedOffset.width
                        endedOffset.height += changedOffset.height
                        changedOffset = .zero
                    }
            )
    }
}
```
- `minimumDistance` 當拖曳值超過此設定量，才會執行程式碼
- `coordinateSpace` 拖曳值的判斷基準

# 組合手勢
---
在特定情況下，可能不想要 `View` 直接被拖曳，會需要組合特定手勢。以下三種修飾器提供手勢的組合：

- `.simultaneously` 同時
- `.sequenced` 依序
- `.exclusive` 專門

例如想要在長按兩秒後，拖曳才會生效：

![https://ithelp.ithome.com.tw/upload/images/20230930/20162383ShOSbtK58b.png](https://ithelp.ithome.com.tw/upload/images/20230930/20162383ShOSbtK58b.png)

```swift
struct ContentView: View {
    @State private var changedOffset: CGSize = .zero
    @State private var endedOffset: CGSize = .zero
    
    var body: some View {
        Image(systemName: "iphone")
            .font(.system(size: 150))
            .offset(changedOffset)
            .offset(endedOffset)
            .gesture(
                LongPressGesture(minimumDuration: 2, maximumDistance: .zero)
                    .sequenced(before:
                        DragGesture(minimumDistance: .zero, coordinateSpace: .global)
                            .onChanged { value in
                                changedOffset.width = value.translation.width
                                changedOffset.height = value.translation.height
                            }
                            .onEnded { value in
                                endedOffset.width += changedOffset.width
                                endedOffset.height += changedOffset.height
                                changedOffset = .zero
                            }
                    )
            )
    }
}
```

我們在 `LongPressGesture` 之後用 `.sequenced` 加入 `DragGesture`，達到長按兩秒才能拖曳。

但是長按兩秒沒有任何指示告訴用戶現在可以拖曳了，所以我們可以在長按後加入縮放變化：

![https://ithelp.ithome.com.tw/upload/images/20230930/20162383FGe5rjrAIU.png](https://ithelp.ithome.com.tw/upload/images/20230930/20162383FGe5rjrAIU.png)

```swift
struct ContentView: View {
    @State private var changedOffset: CGSize = .zero
    @State private var endedOffset: CGSize = .zero
    @State private var isLongPressed: Bool = false
    
    var body: some View {
        Image(systemName: "iphone")
            .font(.system(size: 150))
            .scaleEffect(isLongPressed ? 1.5 : 1)
            .offset(changedOffset)
            .offset(endedOffset)
            .gesture(
                LongPressGesture(minimumDuration: 1, maximumDistance: .zero)
                    .onEnded { _ in
                        withAnimation {
                            isLongPressed = true
                        }
                    }
                    .sequenced(before:
                        DragGesture(minimumDistance: .zero, coordinateSpace: .global)
                            .onChanged { value in
                                changedOffset.width = value.translation.width
                                changedOffset.height = value.translation.height
                            }
                            .onEnded { value in
                                endedOffset.width += changedOffset.width
                                endedOffset.height += changedOffset.height
                                changedOffset = .zero
                                withAnimation {
                                    isLongPressed = false
                                }
                            }
                    )
            )
    }
}
```

> 在 `Canvas` 長按並拖曳試試

# 總結
---
手勢在 APP 中擔任很重要的角色。

本章介紹了很多不同的手勢，利用 `.gesture` 來辨識手勢，再加入不同手勢及組合，來到你要的效果。
