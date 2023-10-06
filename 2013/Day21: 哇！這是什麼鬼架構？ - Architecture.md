# 什麼是 Clean Architecture
---
`Clean Architecture` 是由 Uncle Bob（Robert C. Martin）提出的架構，是以 `Clean Code` 為基礎延伸出的架構設計。

`Clean Architecture` 的核心觀念是讓**系統中的商業邏輯是獨立**的：
- **獨立於框架**：把框架當成是工具，而非把系統塞到框架中。所以當抽換框架時也不會影嚮系統商業邏輯的運作。
- **可測試**：在沒有 UI、資料庫、網頁伺服器的情況下可以單純測試商業邏輯。
- **獨立於 UI**：可以在不改變系統架構的情況下改變 UI。
- **獨立於資料庫**：商業邏輯是獨立於資料庫本身，因此即使抽換了資料庫也不會影響系統商業邏輯的運作。
- **獨立於任何其他代理**：商業邏輯可以獨立於其他任何第三方服務。

> Uncle Bob 提出的 `Clean Architecture` 概念圖

![image](CleanArchitecture.jpg) 

我更喜歡以 PJ 大在 [**Go Clean Architectur**](https://pjchender.dev/golang/note-go-clean-architecture/) 文章內的圖來理解：

![image](CA2.png)

> 這張圖主要定義幾個 Layer：
> - **Entities**：類似 Model 層，又稱 Domain。定義 model 的 struct、以及透過
 interface 來定義將被實作的方法。這些定義好的 entities 會在其他不同層中被使用。
> - **Repository**：類似 database 層，負責處理 database 資料的操作，只會對資料庫進行 CRUD 而不會有任何商業邏輯在內，因為在 Domain 層有定義 interface，所以切換 database 也沒關係。這一層會相依於其他資料庫或 micro service（用來交換資料）的服務。
> - **Usecase**：類似 API 或 controller 層，是主要用來處理商業邏輯的（資料處理或運算）。在這層中會決定要使用哪一個 repository，並將資料交給 delivery 或 repository，負責使用  Repository 提供的方法來實際對 database 進行操作，因為 Domain 層有定義 interface，所以可以套用在不同的服務上（例如，gRPC）
> - **Delivery**：類似 router 層，最主要用來決定資料要透過哪種媒介呈現，可以是 Restful API, gRPC 或 HTML 檔案。這層會接受使用者傳遞的資料，並消毒過濾（sanitize）後再往後傳給 usecase 層。

### Entities
`Entities` 就是傳送/顯示的資料，比如說我們前幾章使用的 `Member` 就是 `Entities Layer` 的結構。

### Repository
`Repository` 簡單來說就是資料 CRUD 的邏輯。

但跟我們前幾章 `SQLite` 不同的是，這邊的取得資料需要以 Protocol 定義，因為會需要是獨立於資料庫的。因此如何實作並不是重點，可以從資料庫ㄎ，也可以從網路取得資料。

### Usecase/Service
`Usecase/Service` 是主要商業邏輯的地方。

比方說取得資料後，怎麼處理資料，最後傳給 UI，就是這邊處理。

### Delivery/Controller
`Delivery/Controller` 對於 `SwiftUI` 來說就是 UI 或 UI 相關的數值。

# SwiftUI Clean Architecture
---
根據 `Clean Architecture` 衍生出的 `SwiftUI Clean Architecture` 結構可以參考 [**nalexn: Clean Architecture for SwiftUI**](https://nalexn.github.io/clean-architecture-swiftui/?utm_source=nalexn_github) 這篇文章。

> 下圖是 nalexn 提出的 `SwiftUI Clean Architecture` 示意圖

![image](swiftui_arc_001_d.png)

上圖分為四個模組，對應 `Clean Architecture` Layer 分別為：
- **Interactor 對應 Usecase/Service**
- **Repository 對應 Repository**
- **AppState 對應 Delivery/Controller**

### Repository
`Repository` 負責處理 CRUD 的邏輯。

### Interactor
`Interactor` 處理主要商業邏輯，主要以業務類型來分類，不同的業務邏輯會有不同的 `Interactor`。

- **不儲存任何狀態 (Stateless)**
- 需要存取資料時就調用 `Repository`
- 處理後的資料一率丟給 `AppState`

### AppState
`AppState` 負責儲存 App, `View` 的狀態，會以推播的方式將資料推送給 `View`。
- **儲存 App, `View` 狀態/變數 (Stateful)**
- 提供 `Publisher` 給 `View` 訂閱

### View
`View` 即是 `SwiftUI.View` 負責畫面顯示。
- 訂閱 `AppState` 的資料，來監聽資料的變化
- 觸發資料變更邏輯時調用 `Interactor`

### Entities
你說 Entities 在哪？直接開個 `Model` 資料夾定義在裡面即可。

### 介面
理想上各模組間要以介面來隔開（ `Swift` 裡的 `Protocol` ）。

才能達到個模組間的解耦，只關注介面，不關注方法內的實作。


# 實作 SwiftUI Clean Architecture
---
要在 `SwiftUI` 專案內實作 `Clean Architecture`，首先我們要先將資料夾劃分好：




# 參考資料
---
- [**Robert C. Martin (Uncle Bob): The Clean Architecture**](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [**PJCHENder: Go Clean Architecture**](https://pjchender.dev/golang/note-go-clean-architecture/)
- [**nalexn: Clean Architecture for SwiftUI**](https://nalexn.github.io/clean-architecture-swiftui/?utm_source=nalexn_github)
- [**nalexn/clean-architecture-swiftui**](https://github.com/nalexn/clean-architecture-swiftui)