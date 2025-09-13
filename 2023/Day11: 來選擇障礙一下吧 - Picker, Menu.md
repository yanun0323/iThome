本章要介紹的是下拉式選單 `Picker` 和 `Menu`。

# Picker
---

`Picker` 是 `SwiftUI` 提供的的下拉式選單，用法如下：

![https://ithelp.ithome.com.tw/upload/images/20230926/201623836rVVPUcPYw.png](https://ithelp.ithome.com.tw/upload/images/20230926/201623836rVVPUcPYw.png)

```swift
struct ContentView: View {
    private let champion: [String] = ["Faker", "MaRin", "Bengi", "Bang", "Wolf", "kkOma"]
    @State private var favorite: String = "None"
    
    var body: some View {
        VStack {
            Picker(selection: $favorite) {
                ForEach(champion, id: \.self) { member in
                    Text(member)
                        .tag(member)
                }
            } label: {
                Text("\(favorite)")
                    .foregroundColor(.white)
                    .frame(width: 100)
                    .padding(5)
                    .background(.red)
                    .cornerRadius(7)
            }
            .pickerStyle(.automatic)
        }
    }
}
```

> 選擇的結果會存入 selection 傳入的 Binding 變數
>
> `ForEach` 內是定義下拉式選項的項目
>
> label 是決定標籤的按鈕內容

>
> `ForEach` 內的 `.tag` 是指點選之後，要傳入 favorite 的數值
>
> `.pickerStyle` 是變更 `Picker` 樣式的修飾器，可以試試看不同樣式

可以點選 `Canvas` 的下拉式選單，看看會有什麼效果。

### `.tag`
`.tag` 可以設定點選該選項後，實際要設定的數值。

可以試試看把上面程式碼的 `.tag` 內容改成下面這樣，再選選看會發生什麼事？

```swift
Text(member)
    .tag("++\(member)")
```

# Menu
---
**可以發現程式碼 `Picker` label 內的 `Text` 雖然有用修飾器變更樣式，但 `Text` 的樣式卻沒有改變**

如果要改變我們要在外面包一層 `Menu`:

![https://ithelp.ithome.com.tw/upload/images/20230926/20162383WXiGg9Qhc1.png](https://ithelp.ithome.com.tw/upload/images/20230926/20162383WXiGg9Qhc1.png)

```swift
struct ContentView: View {
    private let champion: [String] = ["Faker", "MaRin", "Bengi", "Bang", "Wolf", "kkOma"]
    @State private var favorite: String = "None"
    
    var body: some View {
        VStack {
            Menu {
                Picker(selection: $favorite) {
                    ForEach(champion, id: \.self) { member in
                        Text(member)
                            .tag(member)
                    }
                } label: {}
            } label: {
                Text("\(favorite)")
                    .foregroundColor(.white)
                    .frame(width: 100)
                    .padding(5)
                    .background(.red)
                    .cornerRadius(7)
            }
        }
    }
}
```

> `Picker` label 留空，把顯示的內容改寫到 `Menu` label 內

這樣我們就能在 `Menu` 內自訂自己想要的顯示內容了！

**若你是使用其他 `.pickerStyle` 的 `Picker`，`Menu` 方法就沒有效果囉**

# 總結
---

`Picker` 是下拉式選單，並提供不同基本樣式。

`Picker` label 沒有自訂內容樣式效果，需要包一層 `Menu` 才能達到。

