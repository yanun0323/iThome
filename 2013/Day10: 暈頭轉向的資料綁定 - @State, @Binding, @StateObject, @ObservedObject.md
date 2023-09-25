上一章我們學到 `Button`，按鈕都是在需要改變狀態的時候使用的，例如，增/減數量、輸入數值、登入狀態。

要做到這一點，最基本的是需要能改變 `View` 內的變數。

我們先在 `ContentView` 內寫上以下程式碼，預期每按一下按鈕，count 就會加一：
```swift
struct ContentView: View {
    private var count: Int = 0
    
    var body: some View {
        VStack {
            Text("Count: \(count)")
            
            Button("Add Count") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
```

不過這時會發現，這邊的 count 不可變，會噴錯。

![https://ithelp.ithome.com.tw/upload/images/20230925/201623834oDpAHWe65.png](https://ithelp.ithome.com.tw/upload/images/20230925/201623834oDpAHWe65.png)

這時候就要輪到 `State` 登場了！

# @State
---

`@State` 是一個 `屬性包裝器`(`Property Wrapper`)，他會將變數做處理並監聽他的 `記憶體內容` 變化，當變數 `記憶體內容` 改變時，`@State` 就會通知 `View` 要更新顯示內容。

我們將 count 變數前面加上 `@State`，接著點擊看看按鈕，count 會有什麼變化？
```swift
@State private var count: Int = 0
```

![https://ithelp.ithome.com.tw/upload/images/20230925/20162383uXLeJiVLoM.png](https://ithelp.ithome.com.tw/upload/images/20230925/20162383uXLeJiVLoM.png)

> count 加上 `@State` 後可以被按鈕改變。每次改變，畫面顯示的數字也會跟著改變。

那麼現在 count 可以改變了，那假設我們想把 count 傳入另一個 `View`，讓他也可以被改變呢？

我們試試看在 `AnotherView` 內這樣寫：

![https://ithelp.ithome.com.tw/upload/images/20230925/20162383XRpneQAGWt.png](https://ithelp.ithome.com.tw/upload/images/20230925/20162383XRpneQAGWt.png)

```swift
struct AnotherView: View {
    @State var count: Int
    
    var body: some View {
        VStack {
            Text("AnotherView")
                .font(.title)
            Text("Count: \(count)")
            Button("Add Count") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .border(Color.red)
    }
}

struct AnotherView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherView(count: 0)
    }
```

然後在 `ContentView` 裡加上 `AnotherView`：

![https://ithelp.ithome.com.tw/upload/images/20230925/20162383KNpFuido1e.png](https://ithelp.ithome.com.tw/upload/images/20230925/20162383KNpFuido1e.png)

```swift
struct ContentView: View {
    @State private var count: Int = 0
    
    var body: some View {
        VStack {
            Text("ContentView")
                .font(.title)
            Text("Count: \(count)")
            Button("Add Count") {
                count += 1
            }
            .buttonStyle(.borderedProminent)
            
            AnotherView(count: count)
        }
    }
}
```

這時按一下 `ContentView` 和 `AnotherView` 中的按鈕會發現：

`AnotherView` 裡的 count 增加並不會使 `ContentView` 的 count 也增加。

這兩個 `View` 的 count 不是同一個！

如果我們要使兩個 `View` 的 count 都是同 `記憶體` 的話，需要使用 `Binding`。

# @Binding
---
`@Binding` 是一個 `屬性包裝器`(`Property Wrapper`)。它的功用跟 `@State` 很像，只是它是需要綁定 `@State` 來源。什麼意思呢？我們看實際例子。

我們把 `AnotherView` 的 count `@State` 改成 `@Binding`：
```swift
struct AnotherView: View {
    @Binding var count: Int
    ...
}

struct AnotherView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherView(count: .constant(0))
    }
}
```
> 注意 `AnotherView_Previews` 當傳入的參數需要是 `Binding` 時，可以用 `.constant()` 來傳入參數，但這樣畫面並不會跟著變動。
>
> 可以另外寫個 `AnotherPreview` 的 `View` 來包裝 `AnotherView`：
```swift
struct AnotherView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherPreview(count: 0)
    }
}

struct AnotherPreview: View {
    @State var count: Int
    var body: some View {
        AnotherView(count: $count)  
        // Binding 傳入的 State 參數，前面要加上 $
    }
}
```

`ContentView` 中的 `AnotherView`，在傳入的 count 加上一個 `$`，表示我們傳入的是 `Binding`
```swift
AnotherView(count: $count) 
```

![https://ithelp.ithome.com.tw/upload/images/20230925/20162383vwuV6jPyK1.png](https://ithelp.ithome.com.tw/upload/images/20230925/20162383vwuV6jPyK1.png)

這時候再點兩個按鈕看看，你會發現任何一個 `View` 的按鈕都可以同時影響到兩個 count！

# StateObject 及 ObservableObject
---

當我們的變數，不是一個單純的數字或結構而是 `class` 時，你會發現按鈕又無效了！例如下面這個例子：

![https://ithelp.ithome.com.tw/upload/images/20230925/20162383gvXQoK6TFo.png](https://ithelp.ithome.com.tw/upload/images/20230925/20162383gvXQoK6TFo.png)

```swift
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct ContentView: View {
    @State private var person = Person(name: "Faker", age: 5)
    
    var body: some View {
        VStack {
            Text("ContentView")
                .font(.title)
            Text("Count: \(person.age)")
            Button("Add Age") {
                person.age += 1
            }
            .buttonStyle(.borderedProminent)
        }
    }
```

這是因為 `@State` 關注的是 `記憶體內容` 的變化，而 `class` 裡面數值的變化，並不會影響 `class` 本身 `記憶體內容` 的變化（`class` 的 `記憶體內容` 是一個 `位址`）

這時就需要用到 `@StateObject` 屬性包裝器。

`@StateObject` 和 `@State` 有一樣的功用，只是它是給結構使用的，他會監聽結構內的變化。

我們把 `ContentView` 的 person 前面加上 `@StateObject`：

```swift
@StateObject private var person = Person(name: "Faker", age: 5)
```

這時候他會跳出錯誤，告訴我們使用 `@StateObject` 的物件需要實作 `ObservableObject` 這個 `Protocol`：

![https://ithelp.ithome.com.tw/upload/images/20230925/20162383ZAToWtKiW6.png](https://ithelp.ithome.com.tw/upload/images/20230925/20162383ZAToWtKiW6.png)

我們把 `Person` 這個 `class` 實作 `ObservableObject`，然後在想要監聽的屬性前加上 `@Published`：

![https://ithelp.ithome.com.tw/upload/images/20230925/201623835cBDYOsvFB.png](https://ithelp.ithome.com.tw/upload/images/20230925/201623835cBDYOsvFB.png)

```swift
class Person: ObservableObject {
    @Published var name: String
    @Published var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
```
> `@Published` 的功用是，該屬性如果改變，回通知最外層的 `@StateObject` 讓他刷新 `View`

此時我們的按鈕更改 person.age 就可以更新在顯示畫面上了。

![https://ithelp.ithome.com.tw/upload/images/20230925/20162383oyPdygjlte.png](https://ithelp.ithome.com.tw/upload/images/20230925/20162383oyPdygjlte.png)

# @ObservedObject
---

那如果是其他的 `View` 要傳入 `StateObject` 的物件呢？

這時候就是 `@ObservedObject` 屬性包裝器上場的時候了。

如果要很簡單的理解 `@ObservedObject` 的話，可以這樣想：
> `@State` 之於 `@Binding` 就類似 `@StateObject` 之於 `@ObservedObject`

所以如果我們要在 `AnotherView` 裡傳入 person 的話，可以這樣寫：

![https://ithelp.ithome.com.tw/upload/images/20230925/201623838Db7C4t3OD.png](https://ithelp.ithome.com.tw/upload/images/20230925/201623838Db7C4t3OD.png)

```swift
struct AnotherView: View {
    @ObservedObject var person: Person
    
    var body: some View {
        VStack {
            Text("AnotherView")
                .font(.title)
            Text("Age: \(person.age)")
            Button("Add Age") {
                person.age += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .border(Color.red)
    }
}

struct AnotherView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherPreview(person: Person(name: "Faker", age: 5))
    }
}

struct AnotherPreview: View {
    @State var person: Person
    var body: some View {
        AnotherView(person: person)
    }
}
```

最後 `ContentView` 加上 `AnotherView` 就大功告成啦！

![https://ithelp.ithome.com.tw/upload/images/20230925/20162383jJlCSNXxCe.png](https://ithelp.ithome.com.tw/upload/images/20230925/20162383jJlCSNXxCe.png)

```swift
struct ContentView: View {
    @StateObject private var person = Person(name: "Faker", age: 5)
    
    var body: some View {
        VStack {
            Text("ContentView")
                .font(.title)
            Text("Age: \(person.age)")
            Button("Add Age") {
                person.age += 1
            }
            .buttonStyle(.borderedProminent)
            
            AnotherView(person: person)
        }
    }
}

```

# 總結
---
- 要改變變數數值，並可以根據變數改動來刷新畫面，需要使用 `@State`, `@Binding`, `@StateObject`, `@ObservedObject`
- `@State`, `@Binding` 只會關注 `記憶體內容` 的變化
- `@StateObject`, `@ObservedObject` 會關注 `ObservableObject` 內有添加 `@Published` 的屬性變化

- 對不同物件，`View` 要選擇不同的屬性包裝器，可參考下表：

|物件類型|舉例| 初始 / 新建的變數 | 傳遞變數
|:-|:-|:-|:-
|傳值物件 `Pass by Value`| Int, Struct | `@State` | `@Binding`
|傳址物件 `Pass by Address`| Class | `@StateObject` | `@ObservedObject`

# 延伸閱讀

`@StateObject` 和 `@ObservedObject` 的關係其實有一點複雜，想深入研究可以參考以下文章：

- [王巍 - @StateObject 和 @ObservedObject 的区别和使用](https://onevcat.com/2020/06/stateobject/)
- [KuoJed - @ObservedObject的使用](https://medium.com/彼得潘的-swift-ios-app-開發教室/10-observedobject的使用-187eb99d86bb)