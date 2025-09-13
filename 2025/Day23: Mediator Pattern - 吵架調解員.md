# Day 23: Mediator Pattern - 吵架調解員

## 老闆語錄 💬

> "你們不要直接吵架，有事都來找我調解！業務跟技術有糾紛？找我！前端跟後端不合？找我！連茶水間誰先用微波爐都要找我處理！"

## 災難現場 🔥

週二下午 3 點，辦公室突然爆發激烈爭吵聲。你抬頭一看，業務部的小王和技術部的阿強正在激烈討論著什麼。

「這個功能明明很簡單，為什麼要兩個禮拜？」小王拍著桌子。

「簡單？你知道要改多少系統嗎？」阿強也不甘示弱。

這時候，前端工程師小美也加入戰局：「後端 API 格式又改了，我的前端全部要重寫！」

後端工程師老李反駁：「前端一直要求奇怪的資料格式，我們也很無奈啊！」

設計師阿凱也跳出來：「你們都不按我的設計稿做，最後出問題怪我？」

正當吵架聲越來越大時，老闆從辦公室衝出來：「停！都給我停下來！」

所有人瞬間安靜。

老闆嚴肅地說：「我不是說過嗎？有任何部門間的糾紛，都要透過我來調解！你們這樣直接對吵，只會讓問題更複雜！」

他開始在白板上畫圖：「我要建立一個『溝通中心』！所有部門都不要直接溝通，都透過這個中心！」

PM 小陳困惑地問：「那不是很沒效率嗎？」

「不！」老闆指著圖，「這樣更有效率！業務部有需求？告訴溝通中心！技術部有問題？告訴溝通中心！前端需要資料？告訴溝通中心！後端有更新？告訴溝通中心！」

「溝通中心會根據情況，決定要通知誰、怎麼協調、什麼時候開會討論！」老闆越說越興奮，「這樣就不會有人直接衝突，所有溝通都有記錄，問題都能追蹤！」

系統分析師小莉疑惑地問：「那溝通中心要怎麼運作？」

「智能化！」老闆眼神發亮，「系統會知道哪些部門需要協調，自動安排會議，分配任務，追蹤進度！就像企業內部的『外交部』！」

你突然領悟到，老闆在描述 **Mediator Pattern** - **用一個中介物件來封裝一系列物件的互動，讓物件不需要直接相互引用**！

## 模式解析 🧠

Mediator Pattern（中介者模式）是行為型設計模式中的外交官，它的核心思想是：**定義一個封裝一組物件如何互動的物件，中介者使各物件不需要顯式地相互引用，從而達到鬆散耦合**。

在我們的辦公室外交危機中，老闆的溝通中心需求完美地展現了 Mediator Pattern 的本質：

1. **集中協調**：所有溝通透過中介者進行
2. **鬆散耦合**：各部門不直接相互依賴
3. **統一管理**：溝通邏輯集中在中介者
4. **行為封裝**：複雜的協調邏輯被封裝

Mediator Pattern 的核心組件：

- **Mediator**：中介者介面，定義同事物件間的溝通
- **ConcreteMediator**：具體中介者，協調各同事物件
- **Colleague**：同事物件，透過中介者與其他物件溝通
- **ConcreteColleague**：具體同事物件，實作特定業務邏輯

適用情境：

- **複雜互動網路**：多個物件間複雜的相互依賴
- **介面複用**：介面邏輯需要在多個地方重用
- **工作流系統**：多步驟流程的協調管理
- **事件分發**：中央化的事件處理機制

## 程式碼範例 💻

讓我們實作一個「企業溝通協調中心」，展示 Mediator Pattern 的核心概念：

```ts
// 中介者介面
interface TeamMediator {
  notify(sender: TeamMember, event: string, data: string): void;
}

// 同事物件基類
abstract class TeamMember {
  constructor(protected mediator: TeamMediator, protected name: string) {}
}

// 具體同事：業務部
class SalesTeam extends TeamMember {
  requestFeature(feature: string): void {
    console.log(`💼 ${this.name}: 請求新功能 - ${feature}`);
    this.mediator.notify(this, "feature_request", feature);
  }

  receiveResponse(message: string): void {
    console.log(`💼 ${this.name}: ${message}`);
  }
}

// 具體同事：技術部
class TechTeam extends TeamMember {
  evaluateFeature(feature: string): void {
    const approved = Math.random() > 0.5;
    console.log(`⚡ ${this.name}: 評估功能 "${feature}" - ${approved ? "可行" : "困難"}`);
    this.mediator.notify(this, approved ? "feature_approved" : "feature_rejected", feature);
  }

  startDevelopment(feature: string): void {
    console.log(`🔧 ${this.name}: 開始開發 "${feature}"`);
  }
}

// 具體中介者：專案協調中心
class ProjectCoordinator implements TeamMediator {
  constructor(private sales: SalesTeam, private tech: TechTeam) {}

  notify(sender: TeamMember, event: string, data: string): void {
    console.log(`🏢 協調中心: 處理事件 "${event}"`);

    if (event === "feature_request") {
      this.tech.evaluateFeature(data);
    } else if (event === "feature_approved") {
      this.sales.receiveResponse(`功能 "${data}" 已批准！`);
      this.tech.startDevelopment(data);
    } else if (event === "feature_rejected") {
      this.sales.receiveResponse(`功能 "${data}" 被拒絕...`);
    }
  }
}

// 使用範例
const coordinator = new ProjectCoordinator(
  new SalesTeam(null as any, "業務部"),
  new TechTeam(null as any, "技術部")
);

// 重新設置 mediator 引用
const sales = new SalesTeam(coordinator, "業務部");
const tech = new TechTeam(coordinator, "技術部");

// 模擬業務流程
sales.requestFeature("用戶推薦系統");
sales.requestFeature("實時聊天功能");
```

## 生存技巧 🛡️

1. **Mediator 設計原則**：

   - **集中控制**：複雜邏輯集中在中介者
   - **鬆散耦合**：同事物件間不直接依賴
   - **易於擴展**：添加新同事物件相對容易
   - **責任明確**：中介者負責協調，同事負責業務

2. **與老闆溝通策略**：

   - **秩序強調**：展示如何避免混亂的直接溝通
   - **可追溯性**：說明所有溝通都有記錄和追蹤
   - **擴展彈性**：展示如何輕易添加新部門
   - **效率提升**：強調減少無效溝通和衝突

3. **技術實作要點**：

   - **介面設計**：中介者介面要足夠通用
   - **事件機制**：設計清晰的事件通知機制
   - **狀態管理**：中介者需要維護協調狀態
   - **效能考量**：避免中介者成為效能瓶頸

4. **架構決策建議**：
   - **複雜度評估**：確認互動真的複雜到需要中介者
   - **單一職責**：避免中介者承擔過多責任
   - **替代方案**：考慮事件匯流排等其他協調機制
   - **測試策略**：重點測試中介者的協調邏輯

## 明日預告 🔮

明天我們將探討 **Memento Pattern - 時光倉庫管理員**，學習如何應對老闆的囤積症候群：「把每個版本都保存起來，說不定哪天我又想要舊版本！」

準備迎接時光旅行的挑戰！ ⏰
