彈出視窗在很多情況都會用到，比如確認使用者行為、顯示重要訊息 ...。

本章要介紹 `SwiftUI` 提供的三種彈出視窗，可以根據不同的場景使用對應的彈出視窗。

# `.alert`
---
`.alert` 修飾器提供了一個警告視窗可以使用。
```swift
.alert(_ titleKey, isPresented: Binding<Bool>, action: (() -> Void)?, content: () -> View)
```

![https://ithelp.ithome.com.tw/upload/images/20230928/201623831gZTbTGh2R.png](https://ithelp.ithome.com.tw/upload/images/20230928/201623831gZTbTGh2R.png)

```swift
struct ContentView: View {
    @State private var showAlert: Bool = false
    var body: some View {
        VStack {
            Button {
                showAlert = true
            } label: {
                Text("Show Alert")
            }
            .buttonStyle(.borderedProminent)
        }
        .alert("This Is A Alert", isPresented: $showAlert) {
            Button("OK") {
                print("OK")
            }
        } message: {
            Text("do you want know more about it?")
        }

    }
}
```
- titleKey：警告視窗的標題。
- isPresented：傳入一個 `Binding` 變數，來判斷是否要顯示警告。
- message：警告視窗的內文說明。
- action：警告視窗的按鈕區，可以放 `Button`。

`.alert` 內的 action 可以放不同的 `Button`：

> 兩個 `Button`

![https://ithelp.ithome.com.tw/upload/images/20230928/20162383qlgKC5T1b8.png](https://ithelp.ithome.com.tw/upload/images/20230928/20162383qlgKC5T1b8.png)

```swift
.alert("This Is A Alert", isPresented: $showAlert) {
    Button("Cancel") {
        print("Cancel")
    }
    Button("OK") {
        print("OK")
    }
} message: {
    Text("do you want know more about it?")
}
```

> 多個 `Button`，也可以使用 role 來更改按鈕樣式

![https://ithelp.ithome.com.tw/upload/images/20230928/20162383Belx5E627O.png](https://ithelp.ithome.com.tw/upload/images/20230928/20162383Belx5E627O.png)

```swift
.alert("This Is A Alert", isPresented: $showAlert) {
    Button("OK") {
        print("OK")
    }
    Button("Delete", role: .destructive) {
        print("Delete")
    }
    Button("Cancel", role: .cancel) {
        print("Cancel")
    }
} message: {
    Text("do you want know more about it?")
}
```

# .sheet
---
`.sheet` 修飾器提供一個由下而上的彈出介面，可以控制介面大小、塞入自定義的 `View` 及定義使用者關閉介面後要執行的行為。
```swift
.sheet(isPresented: Binding<Bool>, onDismiss: (() -> Void)?, content: () -> View)
```

![https://ithelp.ithome.com.tw/upload/images/20230928/20162383xwiSQmxtBs.png](https://ithelp.ithome.com.tw/upload/images/20230928/20162383xwiSQmxtBs.png)

```swift
struct ContentView: View {
    @State private var showSheet: Bool = false
    var body: some View {
        VStack {
            Button {
                showSheet = true
            } label: {
                Text("Show Sheet")
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $showSheet) {
            print("Dismiss")
        } content: {
            Text("Hello")
                .presentationDetents([.medium, .large])
        }
    }
}
```

- isPresented：傳入一個 `Binding` 變數，來判斷是否要顯示 `Sheet`。
- onDismiss：使用者關閉 `Sheet` 之後要執行的行為。
- content：`Sheet` 內要顯示的 `View`

這邊我在 `content` 內的 `View` 用了 `.presentationDetents` 修飾器來決定 `Sheet` 可以調整的大小。

# .popover
---

`.popover` 修飾器在 `iPhone` 上和 `Sheet` 有一樣的效果，只是少了 `onDismiss`。

不過在 `iPad`,`macOS` 上的顯示方式就比較不一樣了。
```swift
.popover(isPresented: Binding<Bool>, attachmentAnchor: PopoverAttachmentAnchor, arrowEdge: Edge, content: () -> View)
```

> iPhone 顯示和 `Sheet` 一樣

![https://ithelp.ithome.com.tw/upload/images/20230928/20162383TpIdKdb8xR.png](https://ithelp.ithome.com.tw/upload/images/20230928/20162383TpIdKdb8xR.png)

> iPad 上顯示的就比較像所謂的 `Popover`

![https://ithelp.ithome.com.tw/upload/images/20230928/201623830Dvy4xg4uo.png](https://ithelp.ithome.com.tw/upload/images/20230928/201623830Dvy4xg4uo.png)

```swift
struct ContentView: View {
    @State private var showPopover: Bool = false
    var body: some View {
        VStack {
            Button {
                showPopover = true
            } label: {
                Text("Show Popover")
            }
            .buttonStyle(.borderedProminent)
        }
        .popover(isPresented: $showPopover, attachmentAnchor: .rect(.bounds), arrowEdge: .leading) {
            Text("Hello")
                .presentationDetents([.medium, .large])
        }
    }
}
```

- isPresented：傳入一個 `Binding` 變數，來判斷是否要顯示 `Popover`。
- attachmentAnchor：這我也不知道，可以把它刪掉
- arrowEdge：`Popover` 在 `iPad`, `macOS` 中彈出的方向
- content：`Popover` 內要顯示的 `View`

### 更改 Popover 樣式
透過 `.presentationCompactAdaptation` 修飾器，也可以將 `iPhone` 上的 `Popover` 改成跟 `iPad` 上的一樣：

```swift
.presentationCompactAdaptation(.popover)
```

可以自己試試。

# 總結
---

本章介紹的三種彈出視窗，在大多情況下都很好用。

刪除資料可以用 `.alert` 再次確認，貼文留言及輸入可以用 `.sheet` 顯示 ...。

其他就靠你的想像去發掘了！