# Day 29: 模式組合技 - 老闆終極大招

## 老闆語錄 💬

> "我要一個能自動監控市場變化、動態調整策略、記錄所有決策、管理多層審批、同時支援時光回溯的智慧商業系統！而且介面要簡單到我奶奶都會用！"

## 災難現場 🔥

最終 BOSS 戰的週一早晨，老闆穿著他最好的西裝走進會議室，眼神中帶著前所未有的決心。今天，他要提出終極需求。

「各位！」老闆拍了拍桌子，「經過一個月的學習，我現在知道你們的『武器庫』有多強大了！」

他開始在白板上畫一個巨大的架構圖：「現在我要你們把所有設計模式組合起來，建造一個『終極商業智慧系統』！」

系統架構師老王膽怯地問：「您的需求是...？」

「聽好了！」老闆開始列舉，每說一項就在白板上畫一個方塊：

「首先，系統要能『自動監控』所有業務指標，包括銷售、客戶滿意度、員工績效、競爭對手動態！（Observer Pattern）」

「然後，根據不同情況『自動選擇』最佳處理策略，比如促銷策略、人力調配策略、投資策略！（Strategy Pattern）」

「每個決策都要『完整記錄』，而且要能撤銷，萬一我後悔了可以回到之前的狀態！（Command + Memento Pattern）」

「系統要有『多層審批』機制，小錢經理批，大錢我親自批，超大錢要董事會批！（Chain of Responsibility Pattern）」

「還要能『定期稽核』各部門，自動生成稽核報告，發現問題自動預警！（Visitor + Iterator Pattern）」

「各部門之間的溝通都要通過系統協調，避免直接衝突！（Mediator Pattern）」

「系統要能理解自然語言的業務規則，我說『如果Q4業績超過目標20%就發雙薪』，系統要能自動執行！（Interpreter Pattern）」

「所有流程都要標準化，但細節可以客製化！（Template Method Pattern）」

「系統要能根據我的心情和公司狀態調整反應方式！（State Pattern）」

「如果某個職位空缺，系統也不能停止運作！（Null Object Pattern）」

財務主管老趙已經暈了：「這...這要怎麼實現？」

「而且！」老闆繼續，「整個系統的操作介面要像『一個按鈕』一樣簡單！（Facade Pattern）」

PM 小美弱弱地問：「那系統內部不是會非常複雜嗎？」

「對！但複雜性被優雅地隱藏起來！」老闆得意地說，「這就是設計模式的終極奧義！用模式組合技創造『簡單外表，複雜內心』的完美系統！」

你深呼吸一口氣，意識到這是設計模式學習的最終考驗：**如何在一個系統中優雅地組合多種設計模式**。

## 模式解析 🧠

面對老闆的終極大招，我們需要運用「設計模式組合技」。這不是簡單的模式堆疊，而是需要考慮：

### 🎯 組合原則

1. **職責分離**：每個模式負責特定職責，避免重疊
2. **協作互補**：模式間相互增強，形成協同效應
3. **層次清晰**：建立清楚的模式使用層次
4. **擴展靈活**：組合後的系統仍然容易擴展

### 🏗️ 架構分層

**表現層**：Facade Pattern 提供統一介面
**協調層**：Mediator Pattern 管理模式間通信
**業務層**：Strategy + State + Template Method 處理業務邏輯
**資料層**：Observer + Command + Memento 管理資料和歷史
**基礎層**：Null Object + Chain of Responsibility 提供基礎保障

### 🔄 互動模式

- **事件驅動**：Observer → Strategy → Command
- **狀態管理**：State → Template Method → Memento
- **責任鏈路**：Chain of Responsibility → Visitor → Iterator
- **語言解析**：Interpreter → Command → Strategy

## 程式碼範例 💻

讓我們實作這個「終極商業智慧系統」的核心架構：

```ts
// === 1. Facade Pattern：統一入口 ===
class BusinessSystem {
  private eventBus = new EventBus();
  private approvalChain = new ApprovalChain();
  private auditSystem = new AuditSystem();

  // 老闆的一鍵操作
  processRequest(request: string): string {
    console.log(`🎯 處理請求: ${request}`);
    
    // 觸發事件
    this.eventBus.notify({ type: 'request', data: request });
    
    return "請求已處理";
  }

  approve(item: string, amount: number): string {
    return this.approvalChain.process(item, amount);
  }

  audit(): string {
    return this.auditSystem.performAudit();
  }
}

// === 2. Observer Pattern：事件系統 ===
interface Observer {
  update(event: any): void;
}

class EventBus {
  private observers: Observer[] = [];

  subscribe(observer: Observer): void {
    this.observers.push(observer);
  }

  notify(event: any): void {
    this.observers.forEach(obs => obs.update(event));
  }
}

// === 3. Strategy + State：智能決策 ===
class DecisionCenter implements Observer {
  private strategy: Strategy = new NormalStrategy();

  update(event: any): void {
    console.log(`📊 決策中心收到: ${event.type}`);
    this.strategy.handle(event.data);
  }

  setStrategy(strategy: Strategy): void {
    this.strategy = strategy;
  }
}

interface Strategy {
  handle(data: string): void;
}

class NormalStrategy implements Strategy {
  handle(data: string): void {
    console.log(`📋 正常處理: ${data}`);
  }
}

class UrgentStrategy implements Strategy {
  handle(data: string): void {
    console.log(`🚨 緊急處理: ${data}`);
  }
}

// === 4. Chain of Responsibility：審批鏈 ===
abstract class ApprovalHandler {
  protected next?: ApprovalHandler;

  setNext(handler: ApprovalHandler): void {
    this.next = handler;
  }

  abstract handle(item: string, amount: number): string;
}

class ManagerHandler extends ApprovalHandler {
  handle(item: string, amount: number): string {
    if (amount <= 10000) {
      return `👨‍💼 經理批准: ${item}`;
    }
    return this.next?.handle(item, amount) || "超出權限";
  }
}

class DirectorHandler extends ApprovalHandler {
  handle(item: string, amount: number): string {
    if (amount <= 100000) {
      return `👔 總監批准: ${item}`;
    }
    return this.next?.handle(item, amount) || "超出權限";
  }
}

class ApprovalChain {
  private chain: ApprovalHandler;

  constructor() {
    const manager = new ManagerHandler();
    const director = new DirectorHandler();
    manager.setNext(director);
    this.chain = manager;
  }

  process(item: string, amount: number): string {
    return this.chain.handle(item, amount);
  }
}

// === 5. Visitor：稽核系統 ===
interface AuditVisitor {
  visitDepartment(name: string): string;
}

class PerformanceVisitor implements AuditVisitor {
  visitDepartment(name: string): string {
    return `📊 ${name}部門績效檢查完成`;
  }
}

class AuditSystem {
  private departments = ["銷售", "技術", "財務"];

  performAudit(): string {
    const visitor = new PerformanceVisitor();
    const results = this.departments.map(dept => visitor.visitDepartment(dept));
    return `稽核完成: ${results.join(', ')}`;
  }
}

// === 使用範例 ===
const system = new BusinessSystem();
const decisionCenter = new DecisionCenter();

// 建立觀察者關係
system['eventBus'].subscribe(decisionCenter);

console.log("=== 老闆的終極系統 ===");

// 測試各種功能
console.log(system.processRequest("處理客戶投訴"));
console.log(system.approve("購買設備", 25000));
console.log(system.approve("收購公司", 5000000));
console.log(system.audit());

console.log("\n👔 老闆: 一個按鈕解決所有問題！");
```

## 生存技巧 🛡️

### 1. 組合設計原則

**SOLID 在組合中的應用**：
- **S**：每個模式保持單一職責
- **O**：組合對擴展開放，對修改封閉
- **L**：模式可以安全替換
- **I**：介面分離避免不必要依賴
- **D**：依賴抽象而非具體實作

### 2. 模式組合策略

**分層組合**：
```
Facade (統一入口)
├── Mediator (協調層)
├── Observer + Strategy (業務邏輯層)
├── Command + Memento (資料層)
└── Chain + Null Object (基礎層)
```

**流程組合**：
```
Input → Interpreter → Command → Strategy → Observer → Visitor
```

### 3. 複雜性管理

**避免過度複雜**：
- 最多組合 5-7 個模式
- 保持清晰的責任邊界
- 提供良好的文檔和範例
- 建立模式使用指南

**漸進式引入**：
- 從核心模式開始
- 逐步添加輔助模式
- 持續重構和優化
- 監控系統複雜度

### 4. 團隊協作

**知識分享**：
- 建立模式字典
- 定期技術分享
- 程式碼審查標準
- 最佳實踐文檔

**維護策略**：
- 定期重構檢查
- 模式使用監控
- 效能影響評估
- 替代方案準備

## 明日預告 🔮

明天是我們的最後一天：**畢業典禮 - 從韭菜到架構師的成長之路**！

我們將回顧 30 天的學習歷程，總結設計模式的實戰經驗，並展望未來的架構師之路。

準備好接受畢業證書了嗎？ 🎓

記住：**真正的架構師不是會用多少模式，而是知道何時該用哪個模式**！
