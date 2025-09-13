# Day 21: 第三週總結 - 行為型模式上半場

## 老闆語錄 💬

> "現在我們的系統既會觀察、又會思考、還會記憶！但是能不能再聰明一點？"

## 災難現場 🔥

週五下午的技術回顧會議，你剛向老闆展示了這週實作的各種行為型模式：Observer 建立了全方位監控網，Strategy 實現了靈活的策略切換，Command 提供了完美的操作記錄，State 解讀了老闆的心情變化，Template Method 制定了標準流程，Chain of Responsibility 建構了完整的責任鏈。

「太神奇了！」老闆興奮地在會議室裡踱步，「我們的系統現在有『智慧』了！它會觀察環境、調整策略、記錄歷史、理解狀態、遵循流程、分配責任...」

你正暗自慶幸老闆終於理解了行為型模式的價值，他突然停下腳步，眼神發亮：

「等等...既然我們的系統這麼聰明，是不是應該再進化一下？」

系統架構師老王警覺地問：「什麼意思？」

「我想想...」老闆開始在白板上畫圖，「Observer 監控資料變化，然後觸發 Strategy 選擇處理策略，接著用 Command 記錄操作歷史，系統根據 State 調整反應方式，按照 Template Method 執行標準流程，如果遇到問題就用 Chain of Responsibility 找負責人處理！」

PM 小美頭暈地說：「這...這是要把所有模式串起來？」

「對！」老闆得意地拍手，「這就是『行為型模式生態系統』！每個模式各司其職，但又協同作戰！」

前端主管阿凱擔心地問：「會不會太複雜？」

「不會！」老闆堅定地說，「複雜性隱藏在設計裡，對使用者來說還是很簡單！這就是好設計的標誌！」

你突然意識到，老闆雖然常常天馬行空，但他確實領悟了行為型模式的精髓：**讓物件之間的協作更加優雅和靈活**。

## 模式解析 🧠

經過這週的學習，我們掌握了行為型模式的六大精髓。讓我們回顧一下這些「溝通技巧」：

### 👁️ Observer Pattern - 情報網建構

**核心價值**：一對多的依賴關係，狀態改變時自動通知
**老闆翻譯**：「有風吹草動就要立刻報告」
**適用時機**：事件系統、資料監控、MVC 架構

**關鍵學習**：
- 鬆散耦合的通知機制
- 推拉模式的選擇
- 避免循環依賴

### 🎯 Strategy Pattern - 策略變色龍

**核心價值**：定義算法族群，封裝並可互相替換
**老闆翻譯**：「根據情況選擇不同策略」
**適用時機**：業務規則變化、算法選擇、條件分支過多

**關鍵學習**：
- 消除大量 if-else 結構
- 運行時動態切換算法
- 開放封閉原則的體現

### 📝 Command Pattern - 指令歷史學家

**核心價值**：將請求封裝成物件，支援撤銷和記錄
**老闆翻譯**：「每個指令都要能記錄和撤回」
**適用時機**：操作記錄、撤銷功能、宏命令

**關鍵學習**：
- 請求的參數化和物件化
- 支援撤銷操作的設計
- 宏命令的組合使用

### 🎭 State Pattern - 心情氣象台

**核心價值**：根據內部狀態改變物件行為
**老闆翻譯**：「不同心情做不同決定」
**適用時機**：狀態機實現、條件行為、工作流程

**關鍵學習**：
- 狀態轉換邏輯的封裝
- 避免大量狀態檢查代碼
- 狀態間的轉換控制

### 📋 Template Method Pattern - 流程控制狂

**核心價值**：定義算法骨架，子類實現具體步驟
**老闆翻譯**：「流程固定，細節自己決定」
**適用時機**：算法框架、標準流程、程式碼重用

**關鍵學習**：
- 抽象類的合理使用
- 鉤子方法的靈活應用
- 好萊塢原則的體現

### ⛓️ Chain of Responsibility - 踢皮球大師

**核心價值**：為請求建立處理者鏈，依次處理
**老闆翻譯**：「一層一層往上報，直到有人處理」
**適用時機**：多層處理、權限檢查、錯誤處理

**關鍵學習**：
- 發送者與接收者的解耦
- 動態組織處理鏈
- 處理與傳遞的權衡

## 程式碼範例 💻

讓我們來看一個「行為型模式協同作戰」的實戰範例：

```ts
// 1. Observer Pattern：事件監控基礎
interface Observer {
  update(event: string, data: any): void;
}

class EventSystem {
  private observers: Observer[] = [];

  subscribe(observer: Observer): void {
    this.observers.push(observer);
  }

  notify(event: string, data: any): void {
    this.observers.forEach(observer => observer.update(event, data));
  }
}

// 2. Strategy Pattern：處理策略
interface ProcessingStrategy {
  process(data: any): string;
}

class UrgentStrategy implements ProcessingStrategy {
  process(data: any): string {
    return `🚨 緊急處理: ${data}`;
  }
}

class NormalStrategy implements ProcessingStrategy {
  process(data: any): string {
    return `📋 正常處理: ${data}`;
  }
}

// 3. Command Pattern：操作記錄
interface Command {
  execute(): string;
  undo(): string;
}

class ProcessCommand implements Command {
  constructor(
    private strategy: ProcessingStrategy,
    private data: any
  ) {}

  execute(): string {
    return this.strategy.process(this.data);
  }

  undo(): string {
    return `↶ 撤銷處理: ${this.data}`;
  }
}

// 4. State Pattern：系統狀態
abstract class SystemState {
  abstract handle(context: SystemContext, event: string): void;
}

class IdleState extends SystemState {
  handle(context: SystemContext, event: string): void {
    if (event === "urgent") {
      context.setState(new BusyState());
      context.setStrategy(new UrgentStrategy());
    }
  }
}

class BusyState extends SystemState {
  handle(context: SystemContext, event: string): void {
    if (event === "complete") {
      context.setState(new IdleState());
      context.setStrategy(new NormalStrategy());
    }
  }
}

// 5. Chain of Responsibility：處理鏈
abstract class Handler {
  private nextHandler?: Handler;

  setNext(handler: Handler): Handler {
    this.nextHandler = handler;
    return handler;
  }

  handle(request: string): string {
    if (this.canHandle(request)) {
      return this.process(request);
    }
    
    if (this.nextHandler) {
      return this.nextHandler.handle(request);
    }
    
    return "❌ 無法處理";
  }

  protected abstract canHandle(request: string): boolean;
  protected abstract process(request: string): string;
}

class ManagerHandler extends Handler {
  protected canHandle(request: string): boolean {
    return request.includes("manager");
  }

  protected process(request: string): string {
    return `👨‍💼 經理處理: ${request}`;
  }
}

class DirectorHandler extends Handler {
  protected canHandle(request: string): boolean {
    return request.includes("director");
  }

  protected process(request: string): string {
    return `👔 總監處理: ${request}`;
  }
}

// 6. Template Method Pattern：處理框架
abstract class ProcessingTemplate {
  // 樣板方法
  public process(data: string): string {
    const validated = this.validate(data);
    if (!validated) return "❌ 驗證失敗";

    const processed = this.executeProcessing(data);
    this.logResult(processed);
    
    return processed;
  }

  protected validate(data: string): boolean {
    return data.length > 0;
  }

  protected abstract executeProcessing(data: string): string;

  protected logResult(result: string): void {
    console.log(`📝 記錄結果: ${result}`);
  }
}

// 綜合系統：老闆的智能處理中心
class SystemContext extends ProcessingTemplate implements Observer {
  private state: SystemState = new IdleState();
  private strategy: ProcessingStrategy = new NormalStrategy();
  private commandHistory: Command[] = [];
  private eventSystem = new EventSystem();
  private handlerChain: Handler;

  constructor() {
    super();
    this.eventSystem.subscribe(this);
    this.setupHandlerChain();
  }

  private setupHandlerChain(): void {
    const manager = new ManagerHandler();
    const director = new DirectorHandler();
    manager.setNext(director);
    this.handlerChain = manager;
  }

  setState(state: SystemState): void {
    this.state = state;
    console.log(`🔄 狀態切換: ${state.constructor.name}`);
  }

  setStrategy(strategy: ProcessingStrategy): void {
    this.strategy = strategy;
    console.log(`🎯 策略切換: ${strategy.constructor.name}`);
  }

  // Observer 實現
  update(event: string, data: any): void {
    console.log(`👁️ 監控到事件: ${event}`);
    this.state.handle(this, event);
  }

  // Template Method 實現
  protected executeProcessing(data: string): string {
    // 創建命令
    const command = new ProcessCommand(this.strategy, data);
    this.commandHistory.push(command);

    // 執行命令
    const result = command.execute();

    // 如果需要上級處理
    if (data.includes("escalate")) {
      return this.handlerChain.handle(data);
    }

    return result;
  }

  // 老闆最愛的一鍵操作
  handleBusinessEvent(eventType: string, data: string): string {
    console.log("\n🎮 === 智能處理系統啟動 ===");
    
    // 觸發事件監控
    this.eventSystem.notify(eventType, data);
    
    // 執行處理流程
    const result = this.process(data);
    
    console.log(`✅ 處理完成: ${result}\n`);
    return result;
  }

  undoLastCommand(): string {
    const lastCommand = this.commandHistory.pop();
    return lastCommand ? lastCommand.undo() : "❌ 沒有可撤銷的操作";
  }
}

// 使用範例
console.log("=== 老闆的行為型模式生態系統 ===");

const system = new SystemContext();

// 正常處理
system.handleBusinessEvent("normal", "處理客戶投訴");

// 緊急處理
system.handleBusinessEvent("urgent", "系統出現重大故障");

// 需要上級處理
system.handleBusinessEvent("urgent", "escalate manager 重大決策需求");

// 撤銷操作
console.log("🔙 撤銷:", system.undoLastCommand());
```

## 生存技巧 🛡️

### 1. 模式組合策略

**事件驅動系統**：Observer + Strategy + Command
- Observer 監控事件
- Strategy 選擇處理方式
- Command 記錄操作歷史

**狀態機系統**：State + Template Method + Chain of Responsibility
- State 管理狀態轉換
- Template Method 定義處理框架
- Chain of Responsibility 處理例外情況

### 2. 與老闆溝通重點

- **智能化展示**：強調系統的自主決策能力
- **靈活性說明**：展示如何快速適應業務變化
- **可追溯性**：強調操作記錄和撤銷功能
- **擴展性價值**：說明如何輕易添加新行為

### 3. 避免常見陷阱

- **過度通知**：Observer 模式避免通知風暴
- **策略爆炸**：Strategy 模式控制策略數量
- **命令積累**：Command 模式注意記憶體管理
- **狀態混亂**：State 模式明確狀態轉換規則

### 4. 實戰應用建議

- **從簡單開始**：先實現單一模式，再考慮組合
- **監控效能**：注意模式組合對效能的影響
- **文件化設計**：清楚記錄模式的使用意圖
- **測試覆蓋**：為每種行為模式編寫測試

## 週末思考題 🤔

1. **回顧本週的六種行為型模式，思考它們在你的專案中可以如何應用？**

2. **Observer 和 Strategy 模式如何配合使用？**

3. **Command 模式除了撤銷功能，還能提供什麼價值？**

4. **什麼情況下 State 模式比大量 if-else 更好？**

## 明日預告 🔮

下週我們將繼續探索剩餘的行為型模式！從 **Visitor Pattern** 開始，學習如何應對老闆的稽核強迫症：「我要對每個部門做不同的檢查，但不想改變部門結構！」

更多精彩的行為型模式等著我們：Mediator、Memento、Iterator、Interpreter 和 Null Object！

準備好迎接更複雜的物件協作挑戰！ 🚀

記住：**行為決定價值，協作創造奇蹟**！
