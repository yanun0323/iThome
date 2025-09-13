# Day 28: 第四週總結 - 行為型模式完全攻略

## 老闆語錄 💬

> "現在我們的系統不只會觀察、思考、記憶，還會稽核、調解、巡邏、翻譯、隱形！這就是完美的企業智慧體！"

## 災難現場 🔥

週五下午的終極回顧會議，老闆站在滿滿兩面白板前，上面密密麻麻畫著各種行為型模式的示意圖，眼神中閃爍著瘋狂的光芒。

「太神奇了！」老闆興奮地轉身面對大家，「經過兩週的學習，我們的系統現在有了『完整的行為智慧』！」

他開始指著白板上的圖表：「Observer 讓我們無所不知，Strategy 讓我們靈活應變，Command 讓我們記憶操作，State 讓我們理解心情，Template Method 讓我們標準化流程，Chain of Responsibility 讓我們層層把關...」

停頓了一下，老闆繼續：「Visitor 讓我們深入稽核，Mediator 讓我們和諧溝通，Memento 讓我們時光旅行，Iterator 讓我們巨細靡遺，Interpreter 讓我們智能理解，Null Object 讓我們永不出錯！」

系統架構師老王有點暈眩地說：「這...這是要把所有模式都用上嗎？」

「為什麼不呢？」老闆眼神發亮，「每個模式都解決特定問題，組合起來就是『超級企業大腦』！」

他開始在白板上畫一個巨大的系統圖：「想像一下...Observer 監控所有事件，觸發 Strategy 選擇處理策略，用 Command 記錄每個操作，根據 State 調整反應模式，按 Template Method 執行標準流程，遇到問題用 Chain of Responsibility 找負責人...」

PM 小美頭痛地問：「那其他模式呢？」

「Visitor 定期稽核整個系統，Mediator 協調各部門溝通，Memento 保存關鍵狀態，Iterator 檢查每個細節，Interpreter 理解自然語言規則，Null Object 確保系統永不中斷！」老闆越說越興奮。

前端主管阿凱擔心地說：「這樣會不會太複雜？」

「不會！」老闆堅定地說，「複雜性被優雅地封裝在模式裡，對使用者來說反而更簡單！這就是設計模式的終極奧義！」

你突然意識到，雖然老闆常常天馬行空，但他確實理解了一個重要概念：**行為型模式的協同作戰能力**。

## 模式解析 🧠

經過兩週的學習，我們已經掌握了行為型模式的完整武器庫。讓我們來盤點這 11 個強大的工具：

### 第一梯隊：核心溝通模式

#### 👁️ Observer Pattern - 情報網建構
**老闆語錄**：「有風吹草動就要立刻報告」
**核心價值**：一對多依賴關係，狀態改變時自動通知
**最佳搭檔**：Strategy、Command、State

#### 🎯 Strategy Pattern - 策略變色龍
**老闆語錄**：「根據情況選擇不同策略」
**核心價值**：算法封裝與動態切換
**最佳搭檔**：Observer、State、Template Method

#### 📝 Command Pattern - 指令歷史學家
**老闆語錄**：「每個指令都要能記錄和撤回」
**核心價值**：請求封裝與操作記錄
**最佳搭檔**：Memento、Chain of Responsibility

### 第二梯隊：狀態控制模式

#### 🎭 State Pattern - 心情氣象台
**老闆語錄**：「不同心情做不同決定」
**核心價值**：狀態轉換與行為控制
**最佳搭檔**：Strategy、Observer、Template Method

#### 📋 Template Method Pattern - 流程控制狂
**老闆語錄**：「流程固定，細節自己決定」
**核心價值**：算法框架與步驟定制
**最佳搭檔**：Strategy、Command、Visitor

#### ⛓️ Chain of Responsibility - 踢皮球大師
**老闆語錄**：「一層一層往上報，直到有人處理」
**核心價值**：請求處理鏈與責任分散
**最佳搭檔**：Command、Mediator、Visitor

### 第三梯隊：深度協作模式

#### 🕵️ Visitor Pattern - 稽核特工
**老闆語錄**：「針對不同部門做專業檢查」
**核心價值**：操作與結構分離，雙重分派
**最佳搭檔**：Iterator、Composite、Template Method

#### 🤝 Mediator Pattern - 吵架調解員
**老闆語錄**：「有事都來找我調解」
**核心價值**：集中協調與鬆散耦合
**最佳搭檔**：Observer、Command、State

#### ⏰ Memento Pattern - 時光倉庫管理員
**老闆語錄**：「每個版本都要能恢復」
**核心價值**：狀態捕獲與封裝保護
**最佳搭檔**：Command、State、Strategy

### 第四梯隊：基礎設施模式

#### 🔍 Iterator Pattern - 檢查狂魔
**老闆語錄**：「一個一個檢查，不能漏掉任何細節」
**核心價值**：統一遍歷與封裝保護
**最佳搭檔**：Visitor、Composite、Template Method

#### 🗣️ Interpreter Pattern - 語言翻譯官
**老闆語錄**：「系統要能理解我的話」
**核心價值**：語法定義與動態解釋
**最佳搭檔**：Command、Strategy、Template Method

#### 👻 Null Object Pattern - 空氣員工
**老闆語錄**：「有人但什麼都不做」
**核心價值**：安全預設與透明操作
**最佳搭檔**：任何需要避免 null 檢查的模式

## 程式碼範例 💻

讓我們來看一個「終極企業智慧系統」，展示多個行為型模式的協同作戰：

```ts
// 1. Observer + Strategy + Command 組合
interface SystemEvent {
  type: string;
  data: any;
  timestamp: Date;
}

class EventBus {
  private observers: Observer[] = [];
  private commandHistory: Command[] = [];

  subscribe(observer: Observer): void {
    this.observers.push(observer);
  }

  notify(event: SystemEvent): void {
    this.observers.forEach(observer => observer.update(event));
  }

  executeCommand(command: Command): void {
    command.execute();
    this.commandHistory.push(command);
  }

  undo(): void {
    const command = this.commandHistory.pop();
    command?.undo();
  }
}

// 2. Strategy + State 組合
class BusinessContext {
  private state: BusinessState = new NormalState();
  private strategy: ProcessingStrategy = new NormalStrategy();

  setState(state: BusinessState): void {
    this.state = state;
    this.state.setContext(this);
  }

  setStrategy(strategy: ProcessingStrategy): void {
    this.strategy = strategy;
  }

  handleEvent(event: SystemEvent): string {
    this.state.handle(event);
    return this.strategy.process(event.data);
  }
}

abstract class BusinessState {
  protected context?: BusinessContext;

  setContext(context: BusinessContext): void {
    this.context = context;
  }

  abstract handle(event: SystemEvent): void;
}

class NormalState extends BusinessState {
  handle(event: SystemEvent): void {
    if (event.type === "high_priority") {
      this.context?.setState(new CrisisState());
      this.context?.setStrategy(new CrisisStrategy());
    }
  }
}

class CrisisState extends BusinessState {
  handle(event: SystemEvent): void {
    if (event.type === "resolved") {
      this.context?.setState(new NormalState());
      this.context?.setStrategy(new NormalStrategy());
    }
  }
}

interface ProcessingStrategy {
  process(data: any): string;
}

class NormalStrategy implements ProcessingStrategy {
  process(data: any): string {
    return `📋 正常處理: ${data}`;
  }
}

class CrisisStrategy implements ProcessingStrategy {
  process(data: any): string {
    return `🚨 緊急處理: ${data}`;
  }
}

// 3. Mediator + Visitor 組合
class DepartmentMediator {
  private departments: Department[] = [];

  addDepartment(dept: Department): void {
    this.departments.push(dept);
    dept.setMediator(this);
  }

  notify(sender: Department, event: string, data: any): void {
    this.departments
      .filter(dept => dept !== sender)
      .forEach(dept => dept.handleNotification(event, data));
  }

  conductAudit(visitor: DepartmentVisitor): void {
    console.log("🔍 開始全面稽核");
    this.departments.forEach(dept => dept.accept(visitor));
  }
}

abstract class Department {
  protected mediator?: DepartmentMediator;

  setMediator(mediator: DepartmentMediator): void {
    this.mediator = mediator;
  }

  abstract handleNotification(event: string, data: any): void;
  abstract accept(visitor: DepartmentVisitor): void;
}

interface DepartmentVisitor {
  visitSales(dept: SalesDepartment): void;
  visitTech(dept: TechDepartment): void;
}

class SalesDepartment extends Department {
  handleNotification(event: string, data: any): void {
    console.log(`💼 銷售部收到通知: ${event} - ${data}`);
  }

  accept(visitor: DepartmentVisitor): void {
    visitor.visitSales(this);
  }

  getSalesData(): number {
    return Math.floor(Math.random() * 1000000);
  }
}

class TechDepartment extends Department {
  handleNotification(event: string, data: any): void {
    console.log(`⚡ 技術部收到通知: ${event} - ${data}`);
  }

  accept(visitor: DepartmentVisitor): void {
    visitor.visitTech(this);
  }

  getCodeQuality(): number {
    return Math.floor(Math.random() * 100);
  }
}

class AuditVisitor implements DepartmentVisitor {
  visitSales(dept: SalesDepartment): void {
    const sales = dept.getSalesData();
    console.log(`📊 銷售部稽核: 業績 $${sales}`);
  }

  visitTech(dept: TechDepartment): void {
    const quality = dept.getCodeQuality();
    console.log(`🔧 技術部稽核: 代碼品質 ${quality}分`);
  }
}

// 4. Iterator + Template Method 組合
abstract class ReportTemplate {
  generate(): string {
    const data = this.collectData();
    const processed = this.processData(data);
    return this.formatReport(processed);
  }

  protected abstract collectData(): any[];
  protected abstract processData(data: any[]): any;
  protected abstract formatReport(data: any): string;
}

class DepartmentReport extends ReportTemplate {
  constructor(private departments: Department[]) {
    super();
  }

  protected collectData(): any[] {
    return this.departments.map(dept => {
      if (dept instanceof SalesDepartment) {
        return { type: 'sales', data: dept.getSalesData() };
      } else if (dept instanceof TechDepartment) {
        return { type: 'tech', data: dept.getCodeQuality() };
      }
      return { type: 'unknown', data: 0 };
    });
  }

  protected processData(data: any[]): any {
    return {
      totalDepartments: data.length,
      salesTotal: data.filter(d => d.type === 'sales').reduce((sum, d) => sum + d.data, 0),
      avgQuality: data.filter(d => d.type === 'tech').reduce((sum, d) => sum + d.data, 0) / 
                  data.filter(d => d.type === 'tech').length || 0
    };
  }

  protected formatReport(data: any): string {
    return `📊 部門報告：共${data.totalDepartments}個部門，銷售總額$${data.salesTotal}，平均代碼品質${data.avgQuality.toFixed(1)}分`;
  }
}

// 5. Null Object + Chain of Responsibility 組合
abstract class ApprovalHandler {
  protected nextHandler?: ApprovalHandler;

  setNext(handler: ApprovalHandler): ApprovalHandler {
    this.nextHandler = handler;
    return handler;
  }

  handle(request: ApprovalRequest): string {
    if (this.canHandle(request)) {
      return this.process(request);
    }
    
    // 使用 Null Object 避免 null 檢查
    return this.nextHandler?.handle(request) || new NullApprovalHandler().handle(request);
  }

  protected abstract canHandle(request: ApprovalRequest): boolean;
  protected abstract process(request: ApprovalRequest): string;
}

class ManagerHandler extends ApprovalHandler {
  protected canHandle(request: ApprovalRequest): boolean {
    return request.amount <= 10000;
  }

  protected process(request: ApprovalRequest): string {
    return `👨‍💼 經理批准: ${request.description} ($${request.amount})`;
  }
}

class DirectorHandler extends ApprovalHandler {
  protected canHandle(request: ApprovalRequest): boolean {
    return request.amount <= 50000;
  }

  protected process(request: ApprovalRequest): string {
    return `👔 總監批准: ${request.description} ($${request.amount})`;
  }
}

class NullApprovalHandler extends ApprovalHandler {
  protected canHandle(request: ApprovalRequest): boolean {
    return true; // 總是處理
  }

  protected process(request: ApprovalRequest): string {
    return `🤖 系統自動批准: ${request.description} ($${request.amount}) - 無可用審批人`;
  }
}

interface ApprovalRequest {
  description: string;
  amount: number;
}

// 6. 終極企業智慧系統
class UltimateEnterpriseSystem {
  private eventBus = new EventBus();
  private context = new BusinessContext();
  private mediator = new DepartmentMediator();
  private approvalChain: ApprovalHandler;

  constructor() {
    this.setupApprovalChain();
    this.setupDepartments();
    this.setupObservers();
  }

  private setupApprovalChain(): void {
    const manager = new ManagerHandler();
    const director = new DirectorHandler();
    manager.setNext(director);
    this.approvalChain = manager;
  }

  private setupDepartments(): void {
    this.mediator.addDepartment(new SalesDepartment());
    this.mediator.addDepartment(new TechDepartment());
  }

  private setupObservers(): void {
    this.eventBus.subscribe({
      update: (event: SystemEvent) => {
        console.log(`🔔 事件通知: ${event.type} - ${event.data}`);
        this.context.handleEvent(event);
      }
    });
  }

  // 老闆的一鍵操作
  handleBusinessEvent(type: string, data: any): void {
    console.log(`\n🎮 === 處理業務事件: ${type} ===`);
    
    const event: SystemEvent = {
      type,
      data,
      timestamp: new Date()
    };

    this.eventBus.notify(event);
  }

  conductFullAudit(): void {
    console.log(`\n🔍 === 全面稽核開始 ===`);
    this.mediator.conductAudit(new AuditVisitor());
  }

  processApproval(description: string, amount: number): string {
    console.log(`\n📋 === 審批流程 ===`);
    const request: ApprovalRequest = { description, amount };
    return this.approvalChain.handle(request);
  }

  generateReport(): string {
    console.log(`\n📊 === 生成報告 ===`);
    const report = new DepartmentReport([]);
    return report.generate();
  }
}

// 使用範例
console.log("=== 老闆的終極企業智慧系統 ===");

const system = new UltimateEnterpriseSystem();

// 處理各種業務事件
system.handleBusinessEvent("sales_update", "Q4銷售達標");
system.handleBusinessEvent("high_priority", "系統故障");
system.handleBusinessEvent("resolved", "故障已修復");

// 進行全面稽核
system.conductFullAudit();

// 處理審批請求
console.log(system.processApproval("購買新設備", 8000));
console.log(system.processApproval("系統升級", 45000));
console.log(system.processApproval("大樓改建", 1000000));

// 生成綜合報告
console.log(system.generateReport());

console.log("\n✨ === 老闆的夢想實現了！ ===");
```

## 生存技巧 🛡️

### 1. 模式組合指南

**經典組合**：
- **Observer + Strategy + Command**：事件驅動的策略系統
- **State + Template Method**：狀態機與流程控制
- **Mediator + Visitor**：協調與檢查系統
- **Chain of Responsibility + Null Object**：安全的責任鏈
- **Iterator + Template Method**：結構化的資料處理
- **Memento + Command**：可撤銷的操作系統

### 2. 選擇決策樹

```
需要事件通知？ → Observer
需要算法切換？ → Strategy
需要操作記錄？ → Command
需要狀態管理？ → State
需要流程框架？ → Template Method
需要責任分散？ → Chain of Responsibility
需要結構檢查？ → Visitor
需要協調溝通？ → Mediator
需要狀態備份？ → Memento
需要統一遍歷？ → Iterator
需要語法解析？ → Interpreter
需要避免null？ → Null Object
```

### 3. 避免過度設計

**警告信號**：
- 為了用模式而用模式
- 模式組合超過3個
- 代碼比問題本身更複雜
- 團隊成員無法理解

**修正策略**：
- 從最簡單的解決方案開始
- 逐步引入模式
- 保持可讀性優先
- 定期重構簡化

### 4. 與老闆溝通技巧

**展示價值**：
- 用具體案例說明模式帶來的好處
- 強調維護成本的降低
- 展示系統的擴展性和穩定性
- 提供可量化的改進指標

**管理期望**：
- 說明模式不是銀彈
- 解釋引入模式的成本
- 提供循序漸進的實施計畫
- 準備備用方案

## 週末思考題 🤔

1. **哪些行為型模式在你的項目中最有應用價值？**

2. **如何評估引入設計模式的成本效益？**

3. **什麼情況下應該考慮模式組合使用？**

4. **如何向團隊推廣設計模式的使用？**

## 明日預告 🔮

明天我們將進入終極挑戰：**模式組合技 - 老闆終極大招**！學習如何應對老闆同時使用多種套路的複雜情況。

準備迎接設計模式的最終 BOSS 戰！ 🥊

記住：**掌握了行為型模式，你就掌握了系統協作的秘密**！
