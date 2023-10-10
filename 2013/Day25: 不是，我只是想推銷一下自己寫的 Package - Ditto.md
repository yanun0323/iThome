本章要來推銷一下自己寫的套件：[**Ditto**](https://github.com/yanun0323/Ditto)。

裡面主要是放一些我自己開發 Side Project 時很常重工的程式碼。

有興趣可以看一下原始碼，很多功能 README 和本文都沒有提到。

# DIContainer
---
`Ditto` 內有建立一個 `DIContainer`，並實作了 `inject` 方法可以注入 `DIContainer`：

`import Ditto` 之後，`DIContainer` 就要重新定義了。

因為要在 `DIContainer` extension 增加計算屬性的 `AppState`、`Interactor`，所以我們也要在 `AppState`、`Interactor` 內新增 `default` 值：

`AppState.swift`
```swift
struct AppState {
    static private var `default`: AppState = AppState()
    
    var members = CurrentValueSubject<[Member]?, Never>([])
}

extension AppState {
    static func get() -> AppState {
        return AppState()
    }
}
```

`Interactor.swift` 
```swift
struct Interactor {
    static private var `default`: Interactor?
    
    var member: MemberInteractor
    
    init(appState: AppState, isMock: Bool) {
        let repo = Dao(isMock: isMock)
        self.member = MemberInteractorService(appState: appState, repo: repo)
    }
}

extension Interactor {
    static func get(_ isMock: Bool) -> Interactor {
        if Self.default == nil {
            Self.default = Interactor(appState: .get(), isMock: isMock)
        }
        return Self.default!
    }
}
```

最後 `DependencyInjector.swift` 改成這樣：

![https://ithelp.ithome.com.tw/upload/images/20231010/20162383ZuCi04dfyH.png](https://ithelp.ithome.com.tw/upload/images/20231010/20162383ZuCi04dfyH.png)

```swift
import Ditto

extension DIContainer {
    var appState: AppState { AppState.get() }
    var interactor: Interactor { Interactor.get(isMock) }
}
```

我們回到 `XXXApp.swift`，使用 `inject` 注入 `DIContainer`：
```swift
import SwiftUI
import Ditto

@main
struct iThomeAppApp: App {
    private var container = DIContainer()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .inject(container)
        }
    }
}
```

別忘了 `ContentView.swift` 也要 `import Ditto`！

# 元件
---
`Ditto` 定義了我自己常用的一些元件：

### Button
建立按鈕，提供了定義長寬、漸層、圓角。

![https://ithelp.ithome.com.tw/upload/images/20231010/20162383MlXS4psJUi.png](https://ithelp.ithome.com.tw/upload/images/20231010/20162383MlXS4psJUi.png)

```swift
Button(width: 150, height: 50, colors: [.blue, .mint], radius: 10) {
    print("Pressed")
} content: {
    Text("Ditto Button")
        .font(.title2)
        .foregroundColor(.white)
}
```

### Block
建立方塊，提供定義長寬及顏色。如果長寬不給值，就會往外擴展。

![https://ithelp.ithome.com.tw/upload/images/20231010/20162383PTlubKvYrU.png](https://ithelp.ithome.com.tw/upload/images/20231010/20162383PTlubKvYrU.png)

```swift
Block(width: 10, height: 10, color: .red)
Block(width: 10, height: 10)
Block(height: 10, color: .blue)
```

### Separator
建立分隔線，提供定義方向、寬度、顏色。

![https://ithelp.ithome.com.tw/upload/images/20231010/20162383BKEICIPaHN.png](https://ithelp.ithome.com.tw/upload/images/20231010/20162383BKEICIPaHN.png)

```swift
Separator(direction: .horizontal, color: .gray, size: 1.5)
```

### Section
建立區塊，提供定義標題、標題文字、標題顏色、區塊顏色、區塊圓角。

![https://ithelp.ithome.com.tw/upload/images/20231010/20162383ip336pwU5c.png](https://ithelp.ithome.com.tw/upload/images/20231010/20162383ip336pwU5c.png)

```swift
Section("Title", font: .caption, color: .gray, radius: 15, bg: .section) {
    HStack {
        Spacer()
        Text("Content")
        Spacer()
    }
    .padding()
}
```

> `Spacer` 元件會根據 `VStack` / `HStack` 來拓展特定的方向

# Extension
---
其他還有擴展了很多型別的方法，比如說：
- `let color = Color(hex: "#333")`
    - `color.hex`
- `let date = Date(from: "2006-01-02", .Date, .tw, .utc)`
    - `let added = data.addDay(1)`
    - `let added = date.addWeek(1)`
    - `let added = date.addMonth(1)`
    - `let added = date.addYear(1)`
- `UIApplication.dismissKeyboard()`

`...`

有興趣可以看看原始碼～

# 參考資料
---
- [缺很多東西但又算詳細的 README](https://github.com/yanun0323/Ditto/blob/master/README.md)

