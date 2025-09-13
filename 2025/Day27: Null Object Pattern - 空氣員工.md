# Day 27: Null Object Pattern - 空氣員工

## 老闆語錄 💬

> "這個位置要有人，但可以什麼都不做！既不能出錯，也不能影響其他人，就像空氣一樣存在就好！"

## 災難現場 🔥

週一早上的人事討論會議，老闆看著組織架構圖，皺著眉頭思考。

「這裡有個問題...」老闆指著圖上的一個空白位置，「技術總監還沒找到合適的人選，但專案不能停啊！」

HR 主管小陳疑惑地問：「那要怎麼辦？」

「我想想...」老闆在白板上畫圖，「其他部門的人都會問：『技術總監的意見是什麼？』、『技術總監批准了嗎？』、『技術總監參加會議嗎？』」

他繼續說：「但是現在沒有技術總監，每次都要解釋『職位空缺』，然後重新安排流程...太麻煩了！」

系統分析師小莉提出建議：「要不要先找個代理的？」

「代理也有問題！」老闆搖頭，「代理會有自己的意見，會影響決策，萬一做錯決定怎麼辦？」

產品經理阿凱困惑地問：「那要怎麼解決？」

老闆眼神發亮：「我要設立一個『透明職位』！」

「什麼意思？」大家異口同聲。

「就是有這個位置，但什麼都不做！」老闆興奮地解釋，「當有人問技術總監意見時，回答『沒意見』；當需要技術總監批准時，自動『同意』；當邀請技術總監開會時，『默默出席但不發言』！」

前端工程師小美試圖理解：「所以是...虛設職位？」

「不是虛設！」老闆糾正，「是『安全職位』！這個職位永遠不會出錯，因為它什麼都不做；永遠不會阻礙流程，因為它總是配合；永遠不會引起衝突，因為它沒有立場！」

後端工程師老李疑惑：「那系統要怎麼知道這是『空氣職位』？」

「系統不需要知道！」老闆得意地說，「對系統來說，它就是一個正常的技術總監！會參加會議、會給回覆、會簽署文件，只是所有行為都是『無害的』！」

你突然理解了，老闆在描述 **Null Object Pattern** - **提供一個無操作的物件來替代 null 引用，避免 null 檢查**！

## 模式解析 🧠

Null Object Pattern（空物件模式）是行為型設計模式中的隱形人，它的核心思想是：**引入一個無操作的物件來替代 null 引用，這個物件提供預設的行為，避免程式碼中大量的 null 檢查**。

在我們的空氣員工災難中，老闆的透明職位需求完美地展現了 Null Object Pattern 的本質：

1. **無害存在**：提供安全的預設行為
2. **介面一致**：與真實物件具有相同介面
3. **簡化邏輯**：消除 null 檢查的複雜性
4. **透明操作**：客戶端無需知道是空物件

Null Object Pattern 的核心組件：

- **AbstractObject**：定義客戶端期望的介面
- **RealObject**：實作具體業務邏輯的物件
- **NullObject**：提供無操作實作的空物件
- **Client**：使用物件而無需檢查是否為 null

適用情境：

- **預設行為**：需要提供安全的預設操作
- **簡化檢查**：避免繁瑣的 null 檢查
- **Optional 替代**：提供更直觀的可選值處理
- **API 設計**：確保 API 總是返回有效物件

## 程式碼範例 💻

讓我們實作一個「企業職位管理系統」，展示 Null Object Pattern 的核心概念：

```ts
// 員工介面
interface Employee {
  getName(): string;
  getPosition(): string;
  giveOpinion(topic: string): string;
  attendMeeting(meetingName: string): string;
  approveRequest(request: string): boolean;
  getSignature(): string;
}

// 真實員工：技術總監
class TechnicalDirector implements Employee {
  constructor(private name: string) {}

  getName(): string {
    return this.name;
  }

  getPosition(): string {
    return "技術總監";
  }

  giveOpinion(topic: string): string {
    const opinions = [
      "我認為需要更多技術調研",
      "這個方案技術風險較高",
      "建議採用更穩定的技術棧",
      "需要評估效能影響"
    ];
    return opinions[Math.floor(Math.random() * opinions.length)];
  }

  attendMeeting(meetingName: string): string {
    return `💼 ${this.name}: 參加${meetingName}，並提供技術建議`;
  }

  approveRequest(request: string): boolean {
    // 模擬真實審批邏輯
    const shouldApprove = Math.random() > 0.3;
    console.log(`💼 ${this.name}: ${shouldApprove ? '批准' : '拒絕'} "${request}"`);
    return shouldApprove;
  }

  getSignature(): string {
    return `${this.name} - 技術總監`;
  }
}

// 空物件：代理技術總監（空氣員工）
class NullTechnicalDirector implements Employee {
  getName(): string {
    return "代理技術總監";
  }

  getPosition(): string {
    return "技術總監（代理）";
  }

  giveOpinion(topic: string): string {
    return "沒有特別意見，請大家自行決定";
  }

  attendMeeting(meetingName: string): string {
    return `👤 ${this.getName()}: 默默參加${meetingName}`;
  }

  approveRequest(request: string): boolean {
    // 空物件總是批准，避免阻礙流程
    console.log(`👤 ${this.getName()}: 自動批准 "${request}"`);
    return true;
  }

  getSignature(): string {
    return "系統代理 - 技術總監";
  }
}

// 員工工廠
class EmployeeFactory {
  private static technicalDirector: Employee | null = null;

  static setTechnicalDirector(director: Employee | null): void {
    this.technicalDirector = director;
  }

  static getTechnicalDirector(): Employee {
    // 關鍵：永遠不返回 null，而是返回空物件
    return this.technicalDirector || new NullTechnicalDirector();
  }

  static hasTechnicalDirector(): boolean {
    return this.technicalDirector !== null;
  }
}

// 會議系統
class MeetingSystem {
  static conductTechnicalMeeting(topic: string): void {
    console.log(`\n🏢 === ${topic} 技術會議 ===`);
    
    const director = EmployeeFactory.getTechnicalDirector();
    
    console.log(`📋 會議主題: ${topic}`);
    console.log(`👔 參與者: ${director.getName()} (${director.getPosition()})`);
    console.log(`💭 意見: ${director.giveOpinion(topic)}`);
    console.log(`📝 會議記錄: ${director.attendMeeting(topic)}`);
    console.log();
  }
}

// 審批系統
class ApprovalSystem {
  static requestApproval(request: string): boolean {
    console.log(`\n📋 === 審批請求: ${request} ===`);
    
    const director = EmployeeFactory.getTechnicalDirector();
    
    console.log(`👤 審批人: ${director.getName()}`);
    const approved = director.approveRequest(request);
    console.log(`📋 簽名: ${director.getSignature()}`);
    console.log(`✅ 結果: ${approved ? '已批准' : '已拒絕'}\n`);
    
    return approved;
  }
}

// 文件系統
class DocumentSystem {
  static generateReport(): void {
    console.log(`\n📄 === 季度技術報告 ===`);
    
    const director = EmployeeFactory.getTechnicalDirector();
    
    console.log(`報告生成人: ${director.getName()}`);
    console.log(`職位: ${director.getPosition()}`);
    console.log(`技術建議: ${director.giveOpinion("季度技術總結")}`);
    console.log(`簽署: ${director.getSignature()}`);
    console.log();
  }
}

// 任務分配系統
class TaskAssignmentSystem {
  private static tasks: string[] = [
    "程式碼審查",
    "技術架構設計",
    "技術選型決策",
    "團隊技能評估",
    "技術培訓計畫"
  ];

  static assignTasks(): void {
    console.log(`\n📋 === 技術總監任務分配 ===`);
    
    const director = EmployeeFactory.getTechnicalDirector();
    
    console.log(`負責人: ${director.getName()}`);
    
    this.tasks.forEach((task, index) => {
      console.log(`${index + 1}. ${task}`);
      console.log(`   回應: ${director.giveOpinion(task)}`);
      
      if (index < this.tasks.length - 1) {
        console.log();
      }
    });
    console.log();
  }
}

// 使用範例
console.log("=== 老闆的空氣員工管理系統 ===\n");

// 場景一：沒有技術總監的情況
console.log("👔 老闆: 技術總監職位暫時空缺，但業務不能停！\n");

// 系統自動使用空物件，無需額外檢查
MeetingSystem.conductTechnicalMeeting("新產品技術評估");
ApprovalSystem.requestApproval("採購新伺服器");
DocumentSystem.generateReport();
TaskAssignmentSystem.assignTasks();

// 場景二：招聘到真實技術總監
console.log("👔 老闆: 太好了！我們招到了新的技術總監！\n");

EmployeeFactory.setTechnicalDirector(new TechnicalDirector("李技術"));

console.log("=== 有真實技術總監後的情況 ===");
MeetingSystem.conductTechnicalMeeting("系統重構討論");
ApprovalSystem.requestApproval("引入新技術框架");

// 場景三：技術總監離職
console.log("👔 老闆: 糟糕！技術總監離職了！但系統要繼續運作！\n");

EmployeeFactory.setTechnicalDirector(null);

console.log("=== 技術總監離職後，系統無縫切換到代理模式 ===");
ApprovalSystem.requestApproval("緊急系統維護");
DocumentSystem.generateReport();

// 演示系統的透明性
console.log("=== 系統透明性演示 ===");
console.log("無論是否有真實員工，系統都能正常運作：\n");

const testRequests = ["資料庫升級", "雲端遷移", "API 重構"];

// 測試空物件
console.log("📋 使用空物件（代理）:");
EmployeeFactory.setTechnicalDirector(null);
testRequests.forEach(request => {
  const result = ApprovalSystem.requestApproval(request);
  console.log(`結果: ${result ? '✅' : '❌'}`);
});

// 測試真實物件
console.log("📋 使用真實員工:");
EmployeeFactory.setTechnicalDirector(new TechnicalDirector("王總監"));
testRequests.forEach(request => {
  const result = ApprovalSystem.requestApproval(request);
  console.log(`結果: ${result ? '✅' : '❌'}`);
});

// 工廠狀態查詢
console.log("📊 === 系統狀態 ===");
console.log(`是否有真實技術總監: ${EmployeeFactory.hasTechnicalDirector() ? '是' : '否'}`);
console.log(`當前技術總監: ${EmployeeFactory.getTechnicalDirector().getName()}`);
```

## 生存技巧 🛡️

1. **Null Object 設計原則**：

   - **介面一致**：空物件必須實作完整的介面
   - **安全預設**：提供無害且合理的預設行為
   - **透明使用**：客戶端無需知道是否為空物件
   - **避免檢查**：消除 if (obj != null) 的判斷

2. **與老闆溝通策略**：

   - **業務連續性**：強調系統不會因人員變動而中斷
   - **風險控制**：說明空物件如何避免系統錯誤
   - **維護簡化**：展示如何減少複雜的條件判斷
   - **擴展彈性**：解釋如何輕易替換真實實作

3. **技術實作要點**：

   - **合理預設**：空物件的行為要符合業務邏輯
   - **日誌記錄**：空物件的操作要有適當的日誌
   - **效能考量**：避免空物件執行昂貴的操作
   - **狀態管理**：考慮空物件是否需要維護狀態

4. **架構決策建議**：
   - **使用時機**：確認是否真的需要避免 null 檢查
   - **行為定義**：明確定義空物件的預設行為
   - **替代方案**：考慮 Optional 等現代語言特性
   - **測試策略**：確保空物件的行為被充分測試

## 明日預告 🔮

明天我們將進入 **第四週總結 - 行為型模式完全攻略**，回顧所有行為型模式的精髓，並學習如何組合使用這些強大的工具來應對更複雜的老闆需求！

準備迎接行為型模式的終極挑戰！ 🎯
