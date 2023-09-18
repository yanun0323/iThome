接下來要來認識一下 Xcode 中開發比較常會使用到的界面。

這邊只會介紹一些必要的視窗，其他較不重要的資訊會先忽略，或在後面章節提到。

沒提到的，就自己去找吧！

### 歡迎畫面
開啟 Xcode 會看到這個畫面，`Create a new Xcode project` 建立新專案。
如果沒有這個畫面的話也可以從 `File > New > Project...` 開新專案。

![https://ithelp.ithome.com.tw/upload/images/20230917/20162383KIFDUsrd9k.png](https://ithelp.ithome.com.tw/upload/images/20230917/20162383KIFDUsrd9k.png)

### 選擇要開發的軟體類型
上方標籤根據你想要開發的平台，選擇`Multiplatfrom`/`iOS`/`macOS`，這邊選擇 `iOS`。

下幫是要開發的軟體類型，這邊選 `App`。

![https://ithelp.ithome.com.tw/upload/images/20230917/20162383cuVqhU0MnO.png](https://ithelp.ithome.com.tw/upload/images/20230917/20162383cuVqhU0MnO.png)

### 輸入專案資訊
在相對應的欄位填上你要的資訊：
- **Product Name:** 專案名稱
- **Team:** 選擇你的開發者（需要登入你的Apple ID）
- **Organization Identifier:** 發布軟體時會用到的鬼東西，不用改
- **Interface:** SwiftUI（不用問吧）
- **Language:** Swift（這也不用問吧）
- **Use Core Data:** 是否要使用 Apple 自帶的資料庫，不勾
- **Include Tests:** 本次不會介紹測試，也不用勾

![https://ithelp.ithome.com.tw/upload/images/20230917/20162383MhihIEAxpq.png](https://ithelp.ithome.com.tw/upload/images/20230917/20162383MhihIEAxpq.png)

接著資料夾選擇自己要放專案的地方。

### 主要畫面
這邊就是開發APP 的主要畫面了，接下來就按照各個部分解說。

![https://ithelp.ithome.com.tw/upload/images/20230917/20162383S6GznMGkNP.png](https://ithelp.ithome.com.tw/upload/images/20230917/20162383S6GznMGkNP.png)

### 開發區域
- **紅:** 寫程式碼的地方
- **黃:** 左邊程式碼畫面的預覽（詳細內容在下一章節解釋）
- **綠:** 目前選取的檔案、開啟的檔案

![https://ithelp.ithome.com.tw/upload/images/20230917/201623832H8MWp2qdN.png](https://ithelp.ithome.com.tw/upload/images/20230917/201623832H8MWp2qdN.png)

### 資訊區域
- **紅:** `檢視視窗`，選取上方不同圖示可以檢視不同資訊，目前選的第一個資料夾圖示，可以顯示目前專案內有哪些檔案、資料夾
- **黃:** `模擬裝置`，這邊可以更改你要顯示在畫面的裝置、以及實際跑模擬器的裝置
- **綠:** `數值視窗`，顯示當前選取的資料的數值、當前程式碼的數值
- **橘:** `除錯資訊視窗`，跑模擬器時的錯誤資訊會顯示在這邊

> 箭頭處的按鈕，可以顯示/隱藏對應顏色的欄位

![https://ithelp.ithome.com.tw/upload/images/20230917/20162383d0ci3QITFq.png](https://ithelp.ithome.com.tw/upload/images/20230917/20162383d0ci3QITFq.png)

### 除錯資訊視窗
`除錯資訊視窗`打開後注意紅色箭頭這個有沒有開，很多時候會忘記開這個而沒看到跑模擬器時的錯誤資訊。

![https://ithelp.ithome.com.tw/upload/images/20230917/20162383PRi5trYC8M.png](https://ithelp.ithome.com.tw/upload/images/20230917/20162383PRi5trYC8M.png)

### 重要的檔案
這個檔案主要是專案的 Build Setting，需要改動 Build Setting 時就會在這個檔案改動。

![https://ithelp.ithome.com.tw/upload/images/20230917/20162383SGvoCq5JMr.png](https://ithelp.ithome.com.tw/upload/images/20230917/20162383SGvoCq5JMr.png)

這個檔案是放專案 Resource 的地方（圖片、Icon、顏色）

![https://ithelp.ithome.com.tw/upload/images/20230917/20162383aVnbwXYAKh.png](https://ithelp.ithome.com.tw/upload/images/20230917/20162383aVnbwXYAKh.png)

其餘較不重要的介面會在後面的章節提到。

# 用終端機開啟 Xcode 專案
用 VSCode 的各位應該很熟悉直接用終端機指令開啟檔案：
```bash
$ code .
```

Xcode 也有一樣的指令：
```bash
$ xed .
```

以上就是一些基本的介面介紹。