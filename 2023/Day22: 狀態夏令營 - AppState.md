前一章介紹了 `SwiftUI Clean Architecture` 架構的實作，本章詳細介紹 `AppState` 的一些細節。

# View 顯示畫面
---
前一章我們在實作了 `AppState` 結構，並在內部儲存一個 `members` 變數：
```swift
import Foundation
import Combine

struct AppState {
    var members = CurrentValueSubject<[Member]?, Never>([])
}
```

那麼我們該如何在 `View` 內使用呢？

首先我們先在 `ContentView` 內加入 `container` 和 `members`：

![https://ithelp.ithome.com.tw/upload/images/20231007/20162383zIWQzFwo8a.png](https://ithelp.ithome.com.tw/upload/images/20231007/20162383zIWQzFwo8a.png)

```swift
@Environment(\.injected) private var container: DIContainer
@State private var members: [Member] = []
```

接下來把 `members` 顯示畫面刻出來：

![https://ithelp.ithome.com.tw/upload/images/20231007/201623833Ac695oUgb.png](https://ithelp.ithome.com.tw/upload/images/20231007/201623833Ac695oUgb.png)

```swift
@ViewBuilder
private func memberList() -> some View {
    VStack {
        if members.isEmpty {
            Text("Empty Member!")
        } else {
            ForEach(members, id: \.id) { member in
                Text("\(member.id) \(member.name)")
            }
        }
    }
}
```

# 訂閱資料
---
`onReceive` 修飾器提供訂閱 `Publisher` 的功能，我們可以利用 `onReceive` 來訂閱 `AppState` 內的資料：

![https://ithelp.ithome.com.tw/upload/images/20231007/20162383F0pr39KxcZ.png](https://ithelp.ithome.com.tw/upload/images/20231007/20162383F0pr39KxcZ.png)

```swift
.onReceive(container.appState!.members) { data in
    members = data ?? []
}
```

也可以寫成這樣：

![https://ithelp.ithome.com.tw/upload/images/20231007/20162383Qx1JEsc8Q6.png](https://ithelp.ithome.com.tw/upload/images/20231007/20162383Qx1JEsc8Q6.png)

```swift
.onReceive(container.appState!.members) { members = $0 ?? [] }
```

> 這邊 `appState!` 未來會修掉，這邊只是因為方便說明所以把 `AppState` 定義為 `Optional`

**別忘了要把 `PreviewProvider` 內注入 `DIContainer`**，不然 `Canvas` 會噴錯：

![https://ithelp.ithome.com.tw/upload/images/20231007/20162383lxTRFGZg5N.png](https://ithelp.ithome.com.tw/upload/images/20231007/20162383lxTRFGZg5N.png)

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.injected, DIContainer(appState: AppState()))
    }
}
```

# 真的有用嗎？
---
因為目前還沒有實作 `Interactor`，我們可以先實作一個按鈕來測試看看資料有沒有訂閱到：
```swift
@ViewBuilder
private func TestButton() -> some View {
    Button("Test Push Members") {
        let randomID = Int64.random(in: 1...50)
        container.appState?.members.send([
            Member(id: randomID, name: "Faker", position: .Mid),
            Member(id: 50 - randomID, name: "MaRin", position: .Top)
        ])
    }
    .buttonStyle(.borderedProminent)
}
```
> 利用 `send` 方法可以對 `CurrentValueSubject` 推送資料
>
> 這邊用 `Int64.random` 方法來建立亂數的 `id`，方便你從 `id` 判斷資料有沒有改變

實作完按鈕後可以在 `Canvas` 測試看看按下按鈕畫面的資料會不會改變？

最後的程式碼會長這樣：

![https://ithelp.ithome.com.tw/upload/images/20231007/201623830htXB17XKz.png](https://ithelp.ithome.com.tw/upload/images/20231007/201623830htXB17XKz.png)

```swift
import SwiftUI

struct ContentView: View {
    @Environment(\.injected) private var container: DIContainer
    @State private var members = [Member]()
    
    var body: some View {
        VStack {
            memberList()
            TestButton()
        }
        .onReceive(container.appState!.members) { members = $0 ?? [] }
    }
    
    @ViewBuilder
    private func memberList() -> some View {
        VStack {
            if members.isEmpty {
                Text("Empty Member!")
            } else {
                ForEach(members, id: \.id) { member in
                    Text("\(member.id) \(member.name)")
                }
            }
        }
    }
    
    @ViewBuilder
    private func TestButton() -> some View {
        Button("Test Push Members") {
            let randomID = Int64.random(in: 1...50)
            container.appState?.members.send([
                Member(id: randomID, name: "Faker", position: .Mid),
                Member(id: 50 - randomID, name: "MaRin", position: .Top)
            ])
        }
        .buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.injected, DIContainer(appState: AppState()))
    }
}
```

# 總結
---

`View` 利用 `onReceive` 可以訂閱 `AppState` 內的 `Publisher`。

當 `AppState` 內的資料改變時，`View` 就會收到推送並更新顯示的資料。