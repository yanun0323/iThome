接下來就來看看剛剛建立的 SwiftUI 的程式碼是怎麼運作的吧。

# 主要畫面
這個檔案是整個畫面的進入點，主要的畫面會以這個 `struct` 的內容來做顯示。

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383PtKuMbri2t.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383PtKuMbri2t.png)

```swift
import SwiftUI


@main
struct iThomeAppApp: App {      /* 這個結構實作了 App 這個 Protocol */
    var body: some Scene {      // body 決定了畫面顯示的內容
        WindowGroup {           /* WindowGroup 是管理視窗的結構*/
            ContentView()       // 我們的主角，他實作了 View Protocol
        }
    }
}
```

# View 的結構
這是建立專案時 Xcode 就會自動幫你建立好的第一個 View 檔案，我們來瞧瞧他到底是什麼意思。
> 如果你沒有顯示右邊的預覽畫面，請到 Xcode 頂部功能列找到 `Editor` > `Canvas` 將他打勾

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383Y3QBafWzi3.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383Y3QBafWzi3.png)

```swift
import SwiftUI

struct ContentView: View {              // ContentView 實作了 View 這個 Protocol
    var body: some View {               /* body 決定了畫面顯示的內容 */
        VStack {                        // 這邊開始都是 SwiftUI 元件
            Image(systemName: "globe")  // 在之後的章節內會一一介紹
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}
```
# 建立新的 View
> 在 `SwiftUI` 的 `View` 結構內，UI 都是以 `View` 的方式來一層一層堆疊的。

你可以另外再新增一個 View 檔案，Xcode 頂部功能列：`File` > `New` > `File...`

選擇 `SwiftUI View`，取名為 `AnotherView`。

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383VaJSexpbuz.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383VaJSexpbuz.png)

這時候我們把 `ContentView` 內容換成下方這樣，你就可以發現 `ContentView` 顯示的內容會是 `AnotherView`。
```swift
struct ContentView: View {
    var body: some View {
        AnotherView()
    }
}
```

這就是 `View` 的使用方式。

我們可以把不同的畫面組件寫成不同的 `View` 並重複利用的他們。

# View 的使用
既然 `View` 是 `struct`，那當然他也可以儲存變數、定義方法、建構器。例如：
```swift
struct ContentView: View {
    private var name = "Hello"  // 定義變數

    init() {                    // 定義建構器
        PrintName()
    }
    
    var body: some View {
        AnotherView()
    }
    
    func PrintName() {          // 定義方法
        print(name)
    }
}
```

另外 `View` 也有一些基本的 function 可以 call，用來幫 `View` 增加一些屬性。

在 `AnotherView()` 後面打上 `.`，Xcode 就會顯示一些基本 `View` 可以用的 function。

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383Rk3mwAylHR.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383Rk3mwAylHR.png)

一些常見的例子：
```swift
AnotherView()
    .frame(width: 300, height: 50, alignment: .center)  // 設定大小及對齊
    .font(.title)                                       // 設定文字樣式
    .padding(5)                                         // 設定邊距
    .opacity(0.5)                                       // 設定透明度
    .border(Color.red, width: 1)                        // 設定邊框
```

另外 `View` 的 function 也有一個特性是：

**function 的使用順序會影響畫面的產生**

例如這段程式碼：
```swift
AnotherView()
    .font(.title)                   // 1. 改變文字樣式
    .border(Color.blue, width: 1)   // 2. 加上藍色邊框
    .padding(15)                    // 3. 加上 15 的邊距
    .border(Color.red, width: 1)    // 4. 加上紅色邊框
```
兩個邊框的位置會不同，如下圖：

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383e8p0rpOsXo.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383e8p0rpOsXo.png)

所以在使用上要特別注意使用 function 的順序！

# PreviewProvider
每個 `View` 程式碼在撰寫的時候，其實是沒有預覽功能的。

而之所以 Xcode 右邊可以預覽，全是拜 `PreviewProvider` 這個結構所賜。

> 把 `PreviewProvider` 這一段程式都刪掉，看看會發生什麼事。

如果 swift 檔內有 PreviewProvider 的存在，那就會跑出 `PreviewProvider` 內的即時預覽的畫面。

```swift
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {            /* previews 決定預覽的內容 */
        ContentView()                           // 這邊預覽 ContentView
    }
}
```

當然，這裡的 `ContentView` 也可以使用一些方法來改變即時預覽的設定：
```swift
ContentView()
    .preferredColorScheme(.dark)                        // 設定深色模式
    .previewInterfaceOrientation(.landscapeRight)       // 設定方向
    .environment(\.locale, Locale(identifier: "en_us")) // 設定語系
```

上面這段程式碼顯示結果如下：
![https://ithelp.ithome.com.tw/upload/images/20230918/20162383JvDUV3tYLK.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383JvDUV3tYLK.png)

這方法既可以改變預覽的方式，又不會影響到原本在開發的 `ContentView`。

# 即時預覽 - Canvas

即時預覽畫面（以下稱作 Canvas），提供了開發上很便利的一些預覽設定。

如果要更改預覽的裝置，可以在上方這邊變更。

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383Q9S3veCqhd.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383Q9S3veCqhd.png)


雖然可以從 `PreviewProvider` 內改變預覽的設定，但 Canvas 這邊可以很簡單的就做到設定。

## 左下角

### Live（播放圖案）
這個模式可以讓你跟畫面上的元件互動（例如點按鈕他會有反應）

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383nNpM4FZIra.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383nNpM4FZIra.png)

### Selectable（滑鼠游標圖案）
這個模式可以讓你游標移到  UI 元件，他會程式碼區域顯示你游標對應的程式碼。

你游標在哪個程式碼，預覽就會框出相對應的 UI 元件。

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383gOjQMX9Lqo.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383gOjQMX9Lqo.png)

### Variants（六個框框圖案）
- Color Scheme Variants: 同時顯示亮色模式與深色模式

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383S2W7EVorkj.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383S2W7EVorkj.png)

- Orientation Variants: 同時顯示不同方向

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383aiCYbzQwJS.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383aiCYbzQwJS.png)

- Dynamic Type Variants: 同時顯示不同「[動態文字大小](https://support.apple.com/zh-tw/guide/iphone/iph3e2e1fb0/ios)」

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383kEQydKCW11.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383kEQydKCW11.png)

### Device Setting（控制中心圖案）
調整固定的預覽設定

### Preview on Device（小 iPhone 被框起來圖案）
這個只有在你的 Mac 連接著 iPhone 才能使用，他可以讓你直接在你的 iPhone 預覽、操作畫面

其餘 Canvas 的按鈕應該不用解釋，這幾個按鈕亂按不會壞，自己玩玩看吧！

## 左上角

### Pin Preview（圖釘圖案）
釘選這個預覽畫面，當你切換到其他檔案時，會依舊看得到釘選的預覽畫面。

![https://ithelp.ithome.com.tw/upload/images/20230918/20162383xAzR6zYEtO.png](https://ithelp.ithome.com.tw/upload/images/20230918/20162383xAzR6zYEtO.png)

# 總結
本章介紹了 `View`、`PreviewProvider`、`Canvas` 。

下一章節就要來開始寫 Code 囉！