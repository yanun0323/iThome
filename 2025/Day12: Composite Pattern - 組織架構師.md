# Day 12: Composite Pattern - 組織架構師

## 老闆語錄 💬

> "雖然有 PM，但是工程師也要會管專案嘛！"

## 災難現場 🔥

週五早上的專案規劃會議，PM 小美正在介紹新專案的組織架構。她在白板上畫了一個完美的樹狀圖：專案經理在最上層，下面有前端小組、後端小組、測試小組，每個小組又有各自的任務分工。

「這樣分工很清楚啊！」小美自信滿滿地說。

老闆搖搖頭：「太死板了！我希望每個工程師都是獨立的小 PM！」

大家面面相覷，老闆繼續解釋：「你看，阿明可以管理整個前端專案，但他也可以只負責一個小功能。阿華可以帶領後端小組，但必要時也能獨自完成一個模組。」

「這樣不是很混亂嗎？」小美試圖抗議。

「不混亂！」老闆興奮地站起來，「我要的是『可組合的管理架構』！個人是專案，小組是專案，整個部門也是專案！不管是管理一個人還是管理一百個人，操作方式都要一樣！」

他在白板上畫了更複雜的圖：「阿明今天負責『登入功能』，明天可能要管理『整個前端小組』，後天可能要統籌『跨部門協作專案』！每個層級的管理介面都要一致！」

資深工程師老張困惑地問：「那我們要怎麼知道今天是在管理什麼？」

「這就是重點！」老闆眼神發亮，「不管你管的是一個任務還是一個小組，你的管理方法應該都一樣！開會的方式一樣，追蹤進度的方式一樣，分配工作的方式也一樣！」

你突然明白了，老闆其實是在描述 **Composite Pattern** - **統一對待個體物件和組合物件的方式**！

老闆總結：「我們要建立『階層式彈性管理』！每個人都是管理者，每個管理者都能被管理！」

## 模式解析 🧠

Composite Pattern（組合模式）是結構型設計模式中的階層大師，它的核心思想是：**將物件組合成樹狀結構以表示整體-部分的階層關係，讓客戶端能夠統一處理個別物件和物件組合**。

在我們的組織架構災難中，老闆的管理哲學完美地展現了 Composite Pattern 的精髓：

1. **統一介面**：不管管理個人還是團隊，方法都一樣
2. **階層結構**：個人 → 小組 → 部門 → 公司的樹狀組織
3. **遞迴組合**：每個層級都可以包含更小的層級
4. **透明操作**：客戶端不需要區分葉節點和複合節點

Composite Pattern 的核心組件：

- **Component**：定義所有物件的共同介面
- **Leaf**：葉節點，代表最小的個體（如個別員工）
- **Composite**：複合節點，包含其他組件（如部門、小組）

適用情境：

- **階層結構管理**：組織架構、檔案系統、選單結構
- **統一操作需求**：對個體和群體執行相同操作
- **遞迴結構處理**：樹狀資料的統一處理
- **權限管理系統**：角色和權限的階層管理

## 程式碼範例 💻

讓我們實作一個「專案管理組合系統」，展示 Composite Pattern 的核心概念：

```ts
// 專案組件抽象介面
abstract class ProjectComponent {
  protected name: string;

  constructor(name: string) {
    this.name = name;
  }

  abstract executeTask(): string;
  abstract getProgress(): number;
  abstract assignWork(work: string): void;
  abstract getTeamSize(): number;
}

// 葉節點：個別開發者
class Developer extends ProjectComponent {
  private skills: string[];
  private currentTask: string = "";
  private progress: number = 0;

  constructor(name: string, skills: string[]) {
    super(name);
    this.skills = skills;
  }

  executeTask(): string {
    this.progress = Math.min(this.progress + 20, 100);
    return `[開發者 ${this.name}] 執行任務: ${this.currentTask} (進度: ${this.progress}%)`;
  }

  getProgress(): number {
    return this.progress;
  }

  assignWork(work: string): void {
    this.currentTask = work;
    this.progress = 0;
    console.log(`[開發者 ${this.name}] 接收任務: ${work}`);
  }

  getTeamSize(): number {
    return 1;
  }

  getSkills(): string[] {
    return [...this.skills];
  }
}

// 複合節點：開發小組
class DevelopmentTeam extends ProjectComponent {
  private members: ProjectComponent[] = [];

  constructor(name: string) {
    super(name);
  }

  addMember(member: ProjectComponent): void {
    this.members.push(member);
    console.log(`[小組 ${this.name}] 新增成員: ${member.name}`);
  }

  removeMember(member: ProjectComponent): void {
    const index = this.members.indexOf(member);
    if (index > -1) {
      this.members.splice(index, 1);
      console.log(`[小組 ${this.name}] 移除成員: ${member.name}`);
    }
  }

  executeTask(): string {
    const results: string[] = [];
    results.push(`[小組 ${this.name}] 開始執行任務:`);

    this.members.forEach((member) => {
      results.push(`  ${member.executeTask()}`);
    });

    return results.join("\n");
  }

  getProgress(): number {
    if (this.members.length === 0) return 0;

    const totalProgress = this.members.reduce(
      (sum, member) => sum + member.getProgress(),
      0
    );
    return Math.round(totalProgress / this.members.length);
  }

  assignWork(work: string): void {
    console.log(`[小組 ${this.name}] 分配任務: ${work}`);

    // 將大任務拆分給團隊成員
    this.members.forEach((member, index) => {
      const subTask = `${work} - 子任務 ${index + 1}`;
      member.assignWork(subTask);
    });
  }

  getTeamSize(): number {
    return this.members.reduce(
      (size, member) => size + member.getTeamSize(),
      0
    );
  }

  getMembers(): ProjectComponent[] {
    return [...this.members];
  }
}

// 使用範例
console.log("=== 老闆的組合式管理實驗 ===\n");

// 建立個別開發者（葉節點）
const alice = new Developer("Alice", ["React", "TypeScript"]);
const bob = new Developer("Bob", ["Node.js", "MongoDB"]);
const charlie = new Developer("Charlie", ["Python", "AI"]);

// 建立小組（複合節點）
const frontendTeam = new DevelopmentTeam("前端小組");
const backendTeam = new DevelopmentTeam("後端小組");

// 組建團隊
frontendTeam.addMember(alice);
backendTeam.addMember(bob);
backendTeam.addMember(charlie);

// 建立大專案（更大的複合節點）
const webProject = new DevelopmentTeam("Web專案團隊");
webProject.addMember(frontendTeam);
webProject.addMember(backendTeam);

console.log("\n=== 統一管理介面測試 ===");

// 統一的任務分配（不管是個人還是團隊）
alice.assignWork("實作登入頁面");
frontendTeam.assignWork("開發用戶介面");
webProject.assignWork("完成整個Web應用");

console.log("\n=== 統一的執行介面 ===");

// 統一的任務執行（遞迴調用）
console.log("個人執行:");
console.log(alice.executeTask());

console.log("\n小組執行:");
console.log(frontendTeam.executeTask());

console.log("\n專案執行:");
console.log(webProject.executeTask());

console.log("\n=== 統一的進度追蹤 ===");
console.log(`Alice 進度: ${alice.getProgress()}%`);
console.log(`前端小組進度: ${frontendTeam.getProgress()}%`);
console.log(`整個專案進度: ${webProject.getProgress()}%`);

console.log("\n=== 統一的團隊規模查詢 ===");
console.log(`Alice 管理人數: ${alice.getTeamSize()}`);
console.log(`前端小組人數: ${frontendTeam.getTeamSize()}`);
console.log(`整個專案人數: ${webProject.getTeamSize()}`);

// 輸出展示了統一介面如何處理不同層級的物件
```

## 生存技巧 🛡️

1. **Composite 設計原則**：

   - **統一介面**：確保葉節點和複合節點有相同的操作介面
   - **透明性**：客戶端不需要知道操作的是個體還是組合
   - **安全性**：避免在葉節點上調用只適用於複合節點的操作
   - **效能考量**：注意遞迴操作可能帶來的效能問題

2. **與老闆溝通策略**：

   - **階層視覺化**：用組織圖展示 Composite 的階層結構
   - **管理效率**：說明統一介面如何簡化管理複雜度
   - **彈性擴展**：展示如何輕鬆調整組織結構
   - **權責清晰**：解釋每個層級的責任範圍

3. **技術實作要點**：

   - **介面設計**：謹慎設計共同介面，避免過度抽象
   - **記憶體管理**：注意循環引用和記憶體洩漏問題
   - **錯誤處理**：妥善處理子組件的錯誤傳播
   - **快取策略**：為經常查詢的階層資訊添加快取

4. **架構決策建議**：
   - **深度限制**：避免過深的階層結構影響效能
   - **操作原子性**：確保組合操作的原子性和一致性
   - **事件傳播**：設計合適的事件在階層間傳播機制
   - **序列化支援**：考慮階層結構的序列化和反序列化

## 明日預告 🔮

明天我們將探討 **Bridge Pattern - 橋梁工程師**，學習如何應對老闆的統一標準執念：「介面要統一，但實作要多元！」

準備迎接抽象與實作分離的挑戰！ 🌉
