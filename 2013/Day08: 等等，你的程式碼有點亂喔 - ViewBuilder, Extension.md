我們學會了排版、資料顯示，所以接下來可以寫的東西越來越多了。

在這樣的狀況下常常會遇到程式碼沒有分類，像義大利麵條錯綜複雜的狀況。

本章就要跟你分享一些筆者整理程式碼的技巧。

# 整理程式碼
---

假設我們已經完成了以下畫面：

![https://ithelp.ithome.com.tw/upload/images/20230923/20162383TB4Ozcea5h.png](https://ithelp.ithome.com.tw/upload/images/20230923/20162383TB4Ozcea5h.png)

```swift
VStack {
    VStack(spacing: 5) {
        // Champion Members Title
        Text("Champion Members")
            .font(.system(.title, weight: .heavy))
            .foregroundColor(.primary)
        
        // Champion Members List
        VStack(alignment: .leading) {
            ForEach(champion) { member in
                HStack {
                    Image(systemName: "person.fill")
                    Text("This is \(member.name)")
                        .font(.system(.title3, weight: .medium))
                }
                .foregroundColor(.white)
            }
        }
        .padding(15)
        .background(Color.purple)
        .cornerRadius(7)
        .padding(5)
    }
    
    VStack(spacing: 5) {
        // Champion FMVP Title
        Text("FMVP")
            .font(.system(.title, weight: .heavy))
            .foregroundColor(.primary)
        
        // Champion FMVP List
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.fill")
                Text("This is \(champion[1].name)")
                    .font(.system(.title3, weight: .medium))
            }
            .foregroundColor(.white)
        }
        .padding(15)
        .background(Color.purple)
        .cornerRadius(7)
        .padding(5)
    }
}
```

> 這邊畫面大致上可以分成兩個區塊
> 1. Champion Members 區塊
> 1. FMVP 區塊

## body 整理

現在看起來 `body` 裡面是不是有點複雜？

我們可以把這兩個區塊抽出來寫成 Private View Function：

```swift
var body: some View {
        VStack {
            championMembers()
            fmvp()
        }
    }
    
    private func championMembers() -> some View {
        VStack(spacing: 5) {
            // Champion Members Title
            Text("Champion Members")
                .font(.system(.title, weight: .heavy))
                .foregroundColor(.primary)
            
            // Champion Members List
            VStack(alignment: .leading) {
                ForEach(champion) { member in
                    HStack {
                        Image(systemName: "person.fill")
                        Text("This is \(member.name)")
                            .font(.system(.title3, weight: .medium))
                    }
                    .foregroundColor(.white)
                }
            }
            .padding(15)
            .background(Color.purple)
            .cornerRadius(7)
            .padding(5)
        }
    }
    
    private func fmvp() -> some View {
        VStack(spacing: 5) {
            // Champion FMVP Title
            Text("FMVP")
                .font(.system(.title, weight: .heavy))
                .foregroundColor(.primary)
            
            // Champion FMVP List
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "person.fill")
                    Text("This is \(champion[1].name)")
                        .font(.system(.title3, weight: .medium))
                }
                .foregroundColor(.white)
            }
            .padding(15)
            .background(Color.purple)
            .cornerRadius(7)
            .padding(5)
        }
    }
```

現在 `body` 是不是簡潔多了？

## championMembers & fmvp 整理

不過等等，現在另一個問題是 `championMembers` `fmvp` 這兩個 function 有很多重複的程式碼！我們把重複的部分抽出來成一個 function。

經過觀察，`Champion Members` & `FMVP` 這兩個標題可以抽出來。每個成員名字 `This is XXX` 也可以抽出來：
```swift
// `Champion Members` & `FMVP` 兩個標題
private func title(_ title: String) -> some View {
    Text(title)
        .font(.system(.title, weight: .heavy))
        .foregroundColor(.primary)
}

// 每個成員 `This is XXX`
private func listContent(_ name: String) -> some View {
    HStack {
        Image(systemName: "person.fill")
        Text("This is \(name)")
            .font(.system(.title3, weight: .medium))
    }
    .foregroundColor(.white)
}
```

簡化過的 `championMembers` `fmvp` 會長這樣：
```swift
private func championMembers() -> some View {
    VStack(spacing: 5) {
        // Champion Members Title
        title("Champion Members")
        
        // Champion Members List
        VStack(alignment: .leading) {
            ForEach(champion) { member in
                listContent(member.name)
            }
        }
        .padding(15)
        .background(Color.purple)
        .cornerRadius(7)
        .padding(5)
    }
}

private func fmvp() -> some View {
    VStack(spacing: 5) {
        // Champion FMVP Title
        title("FMVP")
        
        // Champion FMVP List
        VStack(alignment: .leading) {
            listContent(champion[1].name)
        }
        .padding(15)
        .background(Color.purple)
        .cornerRadius(7)
        .padding(5)
    }
}
```

## VStack 整理
不過這邊的 List 好像還可以再簡化，這兩個 List 都是用 `VStack`，而且四個修飾器都是一樣的，試試看把它抽出來：
```swift
private func listBlock(_ content: () -> some View) -> some View {
    VStack(alignment: .leading) {
        content()
    }
    .padding(15)
    .background(Color.purple)
    .cornerRadius(7)
    .padding(5)
}
```
> 這邊傳入的 content 是一個回傳 `View` 的`閉包`(`Closure`)，可以讓我們把一些不相同的部分改由 function 外部傳入

簡化過的 `championMembers` `fmvp` 會長這樣：
```swift
private func championMembers() -> some View {
    VStack(spacing: 5) {
        // Champion Members Title
        title("Champion Members")
        
        // Champion Members List
        listBlock {
            ForEach(champion) { member in
                listContent(member.name)
            }
        }
    }
}

private func fmvp() -> some View {
    VStack(spacing: 5) {
        // Champion FMVP Title
        title("FMVP")
        
        // Champion FMVP List
        listBlock {
            listContent(champion[1].name)
        }
    }
}
```

# ViewBuilder
---

`ViewBuilder` 是一個`屬性包裝器`。
> `屬性包裝器`（`Property Wrapper`）是一種語法糖，在變數、函式、結構前加上屬性包裝器，會讓該結構附加上該 `屬性包裝器` 的特性。

![https://ithelp.ithome.com.tw/upload/images/20230923/201623833vo2NIx4r0.png](https://ithelp.ithome.com.tw/upload/images/20230923/201623833vo2NIx4r0.png)

`ViewBuilder` 的優點有很多，但在介紹眾多功能優點之前，有一點跟功能面比較無關，但又影響很大的優點：

**ViewBuilder 可以讓看程式碼的人一眼就了解這個 function 是一個 View**

這是我們在這個章節介紹他的原因，他可以讓整理過後的程式碼更好閱讀。

### 其他的優點
- **可以回傳多個 View**
- **可以使用 if-else**
- **可以定義變數**

### 可以回傳多個 View
一般我們在寫 view function 時，回傳多個 `View` 而不用 `Stack` 包起來會噴錯：
![https://ithelp.ithome.com.tw/upload/images/20230923/20162383LiMkTpWc0G.png](https://ithelp.ithome.com.tw/upload/images/20230923/20162383LiMkTpWc0G.png)

加上 `ViewBuilder` 就沒問題了：
![https://ithelp.ithome.com.tw/upload/images/20230923/20162383HzG0v0deRA.png](https://ithelp.ithome.com.tw/upload/images/20230923/20162383HzG0v0deRA.png)

### 可以使用 if-else
一般我們在寫 view function 時，使用 if-else 會噴錯：
![https://ithelp.ithome.com.tw/upload/images/20230923/201623833HWtKo73Oh.png](https://ithelp.ithome.com.tw/upload/images/20230923/201623833HWtKo73Oh.png)

加上 `ViewBuilder` 就沒問題了：
![https://ithelp.ithome.com.tw/upload/images/20230923/201623830Dm0P8sDEk.png](https://ithelp.ithome.com.tw/upload/images/20230923/201623830Dm0P8sDEk.png)

### 可以定義變數
一般我們在寫 view function 時，在內部定義變數會噴錯：
![https://ithelp.ithome.com.tw/upload/images/20230923/20162383DXgCJpEPDw.png](https://ithelp.ithome.com.tw/upload/images/20230923/20162383DXgCJpEPDw.png)

加上 `ViewBuilder` 就沒問題了：
![https://ithelp.ithome.com.tw/upload/images/20230923/20162383VAUsvZ5pit.png](https://ithelp.ithome.com.tw/upload/images/20230923/20162383VAUsvZ5pit.png)

### 好 ViewBuilder，不加嗎？

# Extension
---

`Extension` 可以再該型別擴充一些屬性、方法。他也可以幫助我們整理我們的程式碼。

想想你在用 `.font` `.foregroundColor` 的時候，輸入的參數只要 `.` 一下就有很多可以讓你選嗎？
> 比如説 `.font` 的 .title, .body；`.foregroundColor` 的 .red, .white

我們可以把一些常用的 Global Setting 也寫進相對應的 `Extension` 內。

一般我會新建一個 `.swift檔` 來管理這些設定：
> Xcode 頂部功能列：`File` > `New` > `File...`
>
> 這邊選 Swift File，取名為 `Settings.swift`

![https://ithelp.ithome.com.tw/upload/images/20230923/20162383KhUMX7JKXd.png](https://ithelp.ithome.com.tw/upload/images/20230923/20162383KhUMX7JKXd.png)

### 以 `VStack` 為例
我們不想要每次輸入 `spacing` 都輸入數字，如果未來要更改設計，這樣全部有 `VStack` 的地方都要改。

預想是會有 `small`、`medium`、`large` 三種大小可以選擇。

他的傳入參數是 `CGFloat` 型別。

我們把 `Settings.swift` 檔案清空，這樣寫：
```swift
import SwiftUI

extension CGFloat {
    static let globalSpacingSmall: CGFloat = 5
    static let globalSpacingMedium: CGFloat = 15
    static let globalSpacingLarge: CGFloat = 30
}
```

![https://ithelp.ithome.com.tw/upload/images/20230923/20162383YkWCG9hYV6.png](https://ithelp.ithome.com.tw/upload/images/20230923/20162383YkWCG9hYV6.png)

這樣我們下次用 `VStack` 的時候就可以直接使用了：

![https://ithelp.ithome.com.tw/upload/images/20230923/20162383jfqj4IJKdB.png](https://ithelp.ithome.com.tw/upload/images/20230923/20162383jfqj4IJKdB.png)

也可以使用在 `.padding`：

![https://ithelp.ithome.com.tw/upload/images/20230923/20162383i1YR5QXixl.png](https://ithelp.ithome.com.tw/upload/images/20230923/20162383i1YR5QXixl.png)

> 適合寫成 Global Setting 的是通用性較高的屬性、可以讓很多元件共用的，比如 `標籤高度`、`按鈕高度`、`背景顏色`
> 
> 不適合寫成 Global Setting 的是比較狹隘的、只有特定的修飾器可以用，比如說 `成員文字寬度`、`註冊按鈕顏色` 之類的。
> 這種狀況比較適合寫在 `View` 的變數內，甚至是 View Function 內。


# 整理成果

整理之後 `ContentView` 的程式碼會長這樣：
```swift
struct ContentView: View {
    var champion: [Member] = [
        Member(name:"Faker"),
        Member(name:"MaRin"),
        Member(name:"Bengi"),
        Member(name:"Bang"),
        Member(name:"Wolf"),
        Member(name:"kkOma")
    ]
    
    var body: some View {
        VStack {
            championMembers()
            fmvp()
        }
    }
    
    @ViewBuilder
    private func championMembers() -> some View {
        VStack(spacing: .globalSpacingSmall) {
            title("Champion Members")
            listBlock {
                ForEach(champion) { member in
                    listContent(member.name)
                }
            }
        }
    }
    
    @ViewBuilder
    private func fmvp() -> some View {
        VStack(spacing: .globalSpacingSmall) {
            title("FMVP")
            listBlock {
                listContent(champion[1].name)
            }
        }
    }
    
    @ViewBuilder
    private func title(_ title: String) -> some View {
        Text(title)
            .font(.system(.title, weight: .heavy))
            .foregroundColor(.primary)
    }
    
    @ViewBuilder
    private func listContent(_ name: String) -> some View {
        HStack {
            Image(systemName: "person.fill")
            Text("This is \(name)")
                .font(.system(.title3, weight: .medium))
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    private func listBlock(_ content: () -> some View) -> some View {
        VStack(alignment: .leading) {
            content()
        }
        .padding(.globalSpacingMedium)
        .background(Color.purple)
        .cornerRadius(7)
        .padding(.globalSpacingSmall)
    }
}
```


# 總結
---

整理程式碼的重點：
- 重複的程式碼可以抽出來
- View Function 加上 `ViewBuilder` 屬性包裝器可以增加可讀性
- Global Setting 可以整理成一個檔案並寫在 `Extension` 內