# NavigationStack
---

`NavigationStack` 提供類似 `iPhone` 設定頁面分頁的元件，可以讓用戶一層一層的點進去每個視窗內。

基本的用法如下：

![https://ithelp.ithome.com.tw/upload/images/20230929/20162383j0OozccsQk.png](https://ithelp.ithome.com.tw/upload/images/20230929/20162383j0OozccsQk.png)

```swift
struct ContentView: View {
    private var champion: [String] = ["Faker", "MaRin", "Bengi", "Bang", "Wolf", "kkOma"]
    var body: some View {
        NavigationStack {
            ForEach(champion, id: \.self) { member in
                NavigationLink {
                    Text(member)
                } label: {
                    Text(member)
                        .font(.title)
                        .padding(5)
                }
            }
        }
    }
}
```

> 可以試試看點擊 `Faker` 的時候會發生什麼事？

`NavigationStack` 內部可以放任何 `View`，如果要讓這個 `View` 可以點擊進下一頁。

需要包裝一層 `NavigationLink` 來讓這個 `View` 可以點進下一頁。

### Title

我們可以使用 `.navigationTitle` 修飾器來加入標題，使用 `.navigationBarTitleDisplayMode` 修飾器來更改標題樣式：

![https://ithelp.ithome.com.tw/upload/images/20230929/20162383o9nfho9Y93.png](https://ithelp.ithome.com.tw/upload/images/20230929/20162383o9nfho9Y93.png)

```swift
NavigationStack {
    ForEach(champion, id: \.self) { member in
        NavigationLink {
            Text(member)
        } label: {
            Text(member)
                .font(.title)
                .padding(5)
        }
    }
    .navigationTitle("Champion")
    .navigationBarTitleDisplayMode(.large)
}
```

### 自訂 View
`NavigationLink` 除了傳入 `Text`，也可以傳入自訂的 `View`，我們先定義一個 `MemberView` 如下：

```swift
struct MemberView: View {
    @State var name: String
    var body: some View {
        HStack {
            Circle()
                .foregroundColor(.gray)
                .frame(width: 300)
                .overlay {
                    Image(systemName: "person")
                        .foregroundColor(.white)
                        .font(.system(size: 150))
                }
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
```

> 這邊的 `.navigationTitle`, `navigationBarTitleDisplayMode` 是這個 `View` 的標題

接著將 `ContentView` 的 `NavigationLink` 中的 `Text` 改成 `MemberView`：

![https://ithelp.ithome.com.tw/upload/images/20230929/20162383VDph1mpMiR.png](https://ithelp.ithome.com.tw/upload/images/20230929/20162383VDph1mpMiR.png)

```swift
NavigationStack {
    ForEach(champion, id: \.self) { member in
        NavigationLink {
            MemberView(name: member)
        } label: {
            Text(member)
                .font(.title)
                .padding(5)
        }
    }
    .navigationTitle("Champion")
    .navigationBarTitleDisplayMode(.large)
}
```

這時候點進去的 `Faker` 就會變成我們自訂的 `View` 了。

![https://ithelp.ithome.com.tw/upload/images/20230929/20162383MQIRrZ6iT5.png](https://ithelp.ithome.com.tw/upload/images/20230929/20162383MQIRrZ6iT5.png)

# 總結
---

`NavigationStack` 可以達到多層的分頁，在很多細節、設定選項的頁面很有用。

試試看在 `NavigationLink` 內自訂的 `View` 內再包一層 `NavigationLink` 會發生什麼事？
