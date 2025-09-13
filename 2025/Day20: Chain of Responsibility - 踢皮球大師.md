# Day 20: Chain of Responsibility - 踢皮球大師

## 老闆語錄 💬

> "先問 A，A 不行問 B，B 不行問 C，最後都不行再來問我！這叫層層把關！"

## 災難現場 🔥

週一早上的問題處理會議，老闆面前擺著一疊客戶投訴單，表情嚴肅地看著每一位主管。

「我們的問題處理效率太低了！」老闆敲著桌子，「客戶有問題就直接找我，這樣我怎麼專心做策略規劃？」

客服主管小雅無辜地說：「因為有些問題比較複雜，我們不知道要找誰處理...」

「那就建立『問題處理鏈』！」老闆站起來在白板上畫圖，「客戶問題先給一線客服，一線解決不了給二線技術，技術解決不了給產品經理，產品經理解決不了給我！」

他繼續畫：「就像醫院的分診制度！感冒先看門診，門診看不了轉專科，專科看不了轉大醫院！每個層級都有自己的處理範圍！」

技術主管老陳困惑地問：「那要怎麼知道問題應該在哪一層處理？」

「自動判斷啊！」老闆眼神發亮，「系統要能智能分析問題類型，然後自動路由到對應的處理人員！」

「而且要有上報機制！」老闆補充，「如果當前層級解決不了，就自動轉給上級！不能讓問題卡在某個人那裡！」

產品經理阿志提出疑問：「那萬一所有人都解決不了怎麼辦？」

「那就是我的問題了！」老闆笑著說，「但是要讓我處理的問題，必須是經過所有層級篩選後的『真正難題』！」

他在白板上畫了一條長長的箭頭：「問題就像接力賽的棒子，每個人都有機會處理，但如果處理不了就要『傳棒』給下一個人！」

客服經理小美試圖理解：「所以問題會在處理鏈中流動？」

「沒錯！」老闆總結，「我們要成為『責任鏈大師』！每個人都有明確的職責範圍，超出範圍就往上傳！這樣既能確保問題得到解決，又能讓每個人專注於自己擅長的領域！」

你恍然大悟，老闆其實是在描述 **Chain of Responsibility Pattern** - **避免請求發送者和接收者耦合在一起，讓多個物件都有可能接收請求，將這些物件連接成一條鏈，並且沿著這條鏈傳遞請求，直到有物件處理它為止**！

## 模式解析 🧠

Chain of Responsibility Pattern（責任鏈模式）是行為型設計模式中的傳遞大師，它的核心思想是：**使多個物件都有機會處理請求，從而避免請求的發送者和接收者之間的耦合關係。將這些物件連成一條鏈，並沿著這條鏈傳遞該請求，直到有一個物件處理它為止**。

在我們的踢皮球災難中，老闆的分層處理需求完美地展現了責任鏈模式的本質：

1. **請求傳遞**：問題沿著處理鏈逐級傳遞
2. **職責分離**：每個層級有明確的處理範圍
3. **動態組合**：可以動態調整處理鏈的結構
4. **鬆散耦合**：發送者不需要知道具體的處理者

Chain of Responsibility Pattern 的核心組件：

- **Handler**：處理者介面，定義處理請求的方法
- **ConcreteHandler**：具體處理者，處理它所負責的請求
- **Client**：客戶端，向鏈上的具體處理者物件提交請求

適用情境：

- **分級處理系統**：客服系統、審批流程、異常處理
- **過濾器鏈**：Web 過濾器、中間件、管道處理
- **事件處理**：GUI 事件冒泡、遊戲事件系統
- **權限驗證**：多層級權限檢查、安全驗證

## 程式碼範例 💻

讓我們實作一個「智能問題處理系統」，展示責任鏈模式的核心概念：

```ts
// 抽象處理者
abstract class Handler {
  protected nextHandler: Handler | null = null;

  setNext(handler: Handler): Handler {
    this.nextHandler = handler;
    return handler;
  }

  handle(request: number): string {
    if (this.canHandle(request)) {
      return this.process(request);
    }

    if (this.nextHandler) {
      return this.nextHandler.handle(request);
    }

    return "無法處理此請求";
  }

  protected abstract canHandle(request: number): boolean;
  protected abstract process(request: number): string;
}

// 具體處理者：初級支援
class BasicSupport extends Handler {
  protected canHandle(request: number): boolean {
    return request <= 100;
  }

  protected process(request: number): string {
    return `初級支援處理請求: ${request}`;
  }
}

// 具體處理者：高級支援
class AdvancedSupport extends Handler {
  protected canHandle(request: number): boolean {
    return request <= 500;
  }

  protected process(request: number): string {
    return `高級支援處理請求: ${request}`;
  }
}

// 具體處理者：經理
class Manager extends Handler {
  protected canHandle(request: number): boolean {
    return request <= 1000;
  }

  protected process(request: number): string {
    return `經理處理請求: ${request}`;
  }
}

// 使用範例
const basicSupport = new BasicSupport();
const advancedSupport = new AdvancedSupport();
const manager = new Manager();

// 建立責任鏈
basicSupport.setNext(advancedSupport).setNext(manager);

// 測試不同級別的請求
console.log(basicSupport.handle(50));   // 初級支援處理請求: 50
console.log(basicSupport.handle(200));  // 高級支援處理請求: 200
console.log(basicSupport.handle(800));  // 經理處理請求: 800
console.log(basicSupport.handle(1500)); // 無法處理此請求
```

## 生存技巧 🛡️

1. **Chain of Responsibility 設計原則**：

   - **單一職責**：每個處理者只負責自己能力範圍內的請求
   - **鬆散耦合**：發送者不需要知道具體哪個處理者會處理請求
   - **動態配置**：可以在運行時動態改變鏈的結構
   - **失敗處理**：要有機制處理整條鏈都無法處理的情況

2. **與老闆溝通策略**：

   - **效率提升**：展示責任鏈如何提高問題處理效率
   - **職責清晰**：說明每個層級的明確職責範圍
   - **自動路由**：強調智能分配的便利性
   - **終極兜底**：保證所有問題最終都能得到處理

3. **技術實作要點**：

   - **鏈式結構**：正確設計和維護處理者鏈
   - **請求格式**：統一請求的資料格式和介面
   - **效能考量**：避免過長的處理鏈影響效能
   - **監控日誌**：記錄請求在鏈中的流轉過程

4. **架構決策建議**：
   - **鏈長控制**：避免責任鏈過長導致的效能問題
   - **循環檢測**：防止處理鏈出現循環引用
   - **並行處理**：考慮是否需要支援並行處理多個請求
   - **狀態管理**：處理者的狀態管理和生命週期

## 系列總結 🎯

恭喜你！我們已經完成了 Day11 到 Day20 的所有內容！讓我們回顧一下這 10 天學到的設計模式：

### 結構型模式完結篇 (Day11-Day14)

- **Proxy Pattern**: 代理人生 - 控制存取和添加功能
- **Composite Pattern**: 組織架構師 - 統一處理個體和群體
- **Bridge Pattern**: 橋梁工程師 - 分離抽象和實作
- **第二週總結**: 結構型模式防身術

### 行為型模式震撼登場 (Day15-Day20)

- **Observer Pattern**: 情報網建構 - 狀態變化的自動通知
- **Strategy Pattern**: 策略變色龍 - 算法的動態切換
- **Command Pattern**: 指令歷史學家 - 操作的封裝和撤銷
- **State Pattern**: 心情氣象台 - 狀態驅動的行為變化
- **Template Method Pattern**: 流程控制狂 - 算法骨架的統一
- **Chain of Responsibility**: 踢皮球大師 - 請求的層層傳遞

每個模式都解決了老闆（和我們）在實際工作中遇到的真實問題，從技術架構到組織管理，從業務流程到用戶體驗。記住：**設計模式不是學院派的理論，而是解決實際問題的實戰工具！**

## 明日預告 🔮

接下來我們將進入更高級的設計模式組合技和實戰應用！準備好迎接更多來自老闆的「創意挑戰」！ 🚀💪
