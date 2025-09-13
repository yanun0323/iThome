# Day 19: Template Method Pattern - 流程控制狂

## 老闆語錄 💬

> "流程是固定的，但細節你們各部門自己決定！我要看到標準化的作業程序！"

## 災難現場 🔥

週五下午的流程優化會議，老闆在白板上畫了一個大大的流程圖，從上到下列出了密密麻麻的步驟。

「我們公司缺乏標準化！」老闆嚴肅地說，「每個部門都有自己的做事方法，太混亂了！」

人事經理小花舉手：「但是每個部門的業務性質不同啊...」

「業務不同，但流程應該一致！」老闆在白板上畫了更多框框，「你看，不管是『招聘新人』、『採購設備』還是『發布產品』，基本流程都一樣！」

他指著流程圖：「第一步：需求評估，第二步：方案規劃，第三步：執行實施，第四步：結果驗收，第五步：後續追蹤！」

財務主管老陳困惑地問：「那細節要怎麼處理？」

「細節由各部門自己決定！」老闆眼神發亮，「比如需求評估這一步，人事部門評估的是人才需求，採購部門評估的是設備需求，但評估的『流程』是一樣的！」

他繼續解釋：「就像做菜一樣！不管做什麼菜，都是『備料 → 調味 → 烹煮 → 擺盤』，但每道菜的具體材料和做法不同！」

工程師小李提出疑問：「那要怎麼確保每個人都遵循這個流程？」

「建立『流程模板』！」老闆越說越興奮，「系統提供標準流程框架，各部門只要填入自己的具體實作就好！不能跳步驟，不能改順序！」

「而且要有檢查點！」老闆補充，「每個步驟完成後要確認，沒完成不能進入下一步！」

產品經理阿明試圖理解：「所以您希望...」

「我希望我們成為『流程標準化大師』！」老闆總結，「骨架統一，血肉各異！每個人都按照標準流程做事，但細節體現專業差異！」

你恍然大悟，老闆其實是在描述 **Template Method Pattern** - **定義一個操作中的算法骨架，將一些步驟延遲到子類別中實作**！

## 模式解析 🧠

Template Method Pattern（樣板方法模式）是行為型設計模式中的流程大師，它的核心思想是：**在一個方法中定義一個算法的骨架，而將一些步驟延遲到子類別中。樣板方法使得子類別可以不改變一個算法的結構即可重定義該算法的某些特定步驟**。

在我們的流程災難中，老闆的標準化需求完美地展現了 Template Method Pattern 的本質：

1. **算法骨架**：定義標準的作業流程
2. **步驟延遲**：具體實作由子類別決定
3. **結構不變**：流程順序固定不可改變
4. **部分可變**：允許部分步驟的客製化

Template Method Pattern 的核心組件：

- **AbstractClass**：抽象類別，定義樣板方法和抽象步驟
- **ConcreteClass**：具體類別，實作抽象步驟
- **Template Method**：樣板方法，定義算法骨架
- **Hook Methods**：鉤子方法，提供可選的擴展點

適用情境：

- **標準化流程**：業務流程、審批流程、製造流程
- **算法框架**：資料處理、檔案解析、報表生成
- **生命週期管理**：元件初始化、測試框架
- **程式碼重用**：相似邏輯的抽象化

## 程式碼範例 💻

讓我們實作一個「標準作業流程系統」，展示 Template Method Pattern 的核心概念：

```ts
// 抽象類別：定義樣板方法
abstract class DataProcessor {
  // 樣板方法：定義固定的處理流程
  public process(): void {
    this.loadData();
    this.processData();
    this.saveData();
  }

  // 抽象方法：子類別必須實作
  protected abstract loadData(): void;
  protected abstract processData(): void;

  // 具體方法：通用邏輯
  protected saveData(): void {
    console.log("資料已儲存");
  }
}

// 具體類別：CSV 處理器
class CSVProcessor extends DataProcessor {
  protected loadData(): void {
    console.log("載入 CSV 檔案");
  }

  protected processData(): void {
    console.log("處理 CSV 資料");
  }
}

// 具體類別：JSON 處理器
class JSONProcessor extends DataProcessor {
  protected loadData(): void {
    console.log("載入 JSON 檔案");
  }

  protected processData(): void {
    console.log("處理 JSON 資料");
  }
}

// 具體類別：XML 處理器
class XMLProcessor extends DataProcessor {
  protected loadData(): void {
    console.log("載入 XML 檔案");
  }

  protected processData(): void {
    console.log("處理 XML 資料");
  }

  // 覆蓋通用方法
  protected saveData(): void {
    console.log("XML 資料已以特殊格式儲存");
  }
}

// 使用範例
const csvProcessor = new CSVProcessor();
csvProcessor.process();
// 輸出:
// 載入 CSV 檔案
// 處理 CSV 資料
// 資料已儲存

console.log("---");

const xmlProcessor = new XMLProcessor();
xmlProcessor.process();
// 輸出:
// 載入 XML 檔案
// 處理 XML 資料
// XML 資料已以特殊格式儲存
```

## 生存技巧 🛡️

1. **Template Method 設計原則**：

   - **Don't call us, we'll call you**：由父類別控制整體流程
   - **最小知識原則**：子類別只需關注自己的具體實作
   - **開放封閉原則**：對擴展開放，對修改封閉
   - **好萊塢原則**：框架調用應用程式，而非相反

2. **與老闆溝通策略**：

   - **流程視覺化**：用流程圖展示標準化的價值
   - **一致性強調**：說明統一流程如何提高效率
   - **彈性保證**：展示在標準中保留客製化空間
   - **品質控制**：解釋檢查點如何確保品質

3. **技術實作要點**：

   - **抽象層次**：合理設計抽象方法和鉤子方法
   - **錯誤處理**：在樣板方法中統一處理異常
   - **擴展性**：預留足夠的擴展點供子類別使用
   - **文檔完善**：清楚說明每個步驟的職責

4. **架構決策建議**：
   - **流程版本管理**：支援流程模板的版本控制
   - **步驟監控**：添加每個步驟的執行監控
   - **並行支援**：考慮部分步驟的並行執行
   - **審計日誌**：記錄完整的流程執行歷史

## 明日預告 🔮

明天我們將探討最後一個模式：**Chain of Responsibility - 踢皮球大師**，學習如何應對老闆的責任分散術：「先問 A，A 不行問 B，B 不行問 C，最後都不行再來問我！」

準備迎接終極的責任鏈挑戰！ ⚽

