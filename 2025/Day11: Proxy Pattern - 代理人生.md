# Day 11: Proxy Pattern - 代理人生

## 老闆語錄 💬

> "我要去打高爾夫，你去幫我開會，不過每個決定都要 LINE 問我！"

## 災難現場 🔥

週四下午 2 點，公司最重要的供應商會議即將開始。就在這關鍵時刻，老闆突然站起來，拿起高爾夫球袋：「我要去談一個很重要的生意，這場會議你代替我參加！」

你慌張地問：「可是我不知道要談什麼條件啊？」

老闆邊走邊說：「沒關係，你就當我的分身！但是記住，任何超過 5000 塊的決定都要 LINE 問我！還有，別讓他們知道我不在，要表現得像我本人一樣！」

會議開始了，供應商代表開口就是：「我們希望提高 30% 的報價...」

你緊張地說：「呃...讓我考慮一下」，然後偷偷傳 LINE 給老闆。

10 分鐘後，老闆回覆：「絕對不行！砍到 10%！」

供應商繼續：「那我們可以縮短付款週期到 15 天嗎？」

你又偷偷傳 LINE...

半小時後，你發現自己變成了一個「即時翻譯機」：把供應商的話轉給老闆，再把老闆的回覆轉給供應商。更誇張的是，你還得偽裝成決策者的樣子，說話要有威嚴感。

「根據我們公司的策略...」（其實是老闆剛傳的訊息）
「這個提案我需要深度思考...」（其實是在等老闆回 LINE）
「我的原則是...」（直接複製貼上老闆的話）

會議結束後，你恍然大悟：我剛剛完美詮釋了 **Proxy Pattern** - 控制對另一個物件的存取，在不改變原有介面的情況下，提供額外的功能！

## 模式解析 🧠

Proxy Pattern（代理模式）是結構型設計模式中的隱形守門員，它的核心思想是：**為其他物件提供一個代理或占位符，以控制對該物件的存取**。

在我們的高爾夫球災難中，老闆的代理需求完美地展現了 Proxy Pattern 的本質：

1. **遠端代理**：你代替不在現場的老闆
2. **權限控制**：超過 5000 元要先詢問
3. **延遲載入**：只有在需要決策時才聯絡老闆
4. **存取日誌**：記錄所有談判過程

Proxy Pattern 的主要類型：

- **虛擬代理**：控制對昂貴物件的存取（如大圖片載入）
- **遠端代理**：控制對遠端物件的存取（如 RPC 調用）
- **保護代理**：控制對原始物件的存取權限
- **快取代理**：為昂貴操作提供快取功能

Proxy Pattern 適用情境：

- **權限控制**：不同用戶有不同的存取權限
- **效能優化**：添加快取或延遲載入
- **日誌記錄**：追蹤物件的使用情況
- **遠端物件**：本地代理遠端服務

## 程式碼範例 💻

讓我們實作一個「老闆代理系統」，展示 Proxy Pattern 的核心概念：

```ts
// 原始物件介面
interface Boss {
  makeDecision(proposal: string, amount: number): string;
  approveExpense(amount: number): boolean;
}

// 真正的老闆（目標物件）
class RealBoss implements Boss {
  private name: string;

  constructor(name: string) {
    this.name = name;
  }

  makeDecision(proposal: string, amount: number): string {
    console.log(`[真老闆 ${this.name}] 正在考慮: ${proposal} (${amount}元)`);
    return amount > 10000 ? `拒絕 ${proposal}` : `批准 ${proposal}`;
  }

  approveExpense(amount: number): boolean {
    console.log(`[真老闆 ${this.name}] 審批費用: ${amount}元`);
    return amount <= 5000;
  }
}

// 代理老闆（Proxy）
class ProxyBoss implements Boss {
  private realBoss: RealBoss;
  private cache: Map<string, string> = new Map();
  private accessLog: string[] = [];

  constructor(realBoss: RealBoss) {
    this.realBoss = realBoss;
  }

  makeDecision(proposal: string, amount: number): string {
    // 存取控制：小額決策可以直接處理
    if (amount < 1000) {
      const quickDecision = `自動批准 ${proposal}`;
      this.logAccess(`小額決策: ${quickDecision}`);
      return quickDecision;
    }

    // 快取檢查：避免重複詢問相同問題
    const cacheKey = `${proposal}-${amount}`;
    if (this.cache.has(cacheKey)) {
      this.logAccess(`從快取返回: ${proposal}`);
      return this.cache.get(cacheKey)!;
    }

    // 權限檢查：高額決策需要老闆親自處理
    if (amount > 5000) {
      this.logAccess(`高額決策轉交老闆: ${proposal} (${amount}元)`);
      console.log("[代理] LINE 傳送中... 等待老闆回覆...");

      const decision = this.realBoss.makeDecision(proposal, amount);
      this.cache.set(cacheKey, decision);
      return decision;
    }

    // 一般決策：代理處理但記錄
    this.logAccess(`代理決策: ${proposal}`);
    const decision = this.realBoss.makeDecision(proposal, amount);
    this.cache.set(cacheKey, decision);
    return decision;
  }

  approveExpense(amount: number): boolean {
    this.logAccess(`費用審批請求: ${amount}元`);

    // 小額費用直接批准
    if (amount < 500) {
      console.log("[代理] 小額費用自動批准");
      return true;
    }

    // 其他費用轉交老闆
    console.log("[代理] 轉交老闆審批...");
    return this.realBoss.approveExpense(amount);
  }

  // 額外功能：存取日誌
  private logAccess(action: string): void {
    const timestamp = new Date().toLocaleTimeString();
    this.accessLog.push(`[${timestamp}] ${action}`);
  }

  getAccessLog(): string[] {
    return [...this.accessLog];
  }

  // 額外功能：快取統計
  getCacheStats(): string {
    return `快取項目: ${this.cache.size}，存取記錄: ${this.accessLog.length}`;
  }
}

// 使用範例
console.log("=== 老闆代理系統 ===\n");

const realBoss = new RealBoss("王老闆");
const proxyBoss = new ProxyBoss(realBoss);

// 模擬會議中的各種決策
console.log("1.", proxyBoss.makeDecision("購買新辦公椅", 800));
console.log("2.", proxyBoss.makeDecision("升級伺服器", 15000));
console.log("3.", proxyBoss.approveExpense(300));
console.log("4.", proxyBoss.approveExpense(2000));

// 重複決策（測試快取）
console.log("5.", proxyBoss.makeDecision("購買新辦公椅", 800));

// 查看代理統計
console.log("\n=== 代理統計 ===");
console.log(proxyBoss.getCacheStats());
console.log("\n=== 存取日誌 ===");
proxyBoss.getAccessLog().forEach((log) => console.log(log));

// 輸出範例：
// 1. 自動批准 購買新辦公椅
// [代理] LINE 傳送中... 等待老闆回覆...
// [真老闆 王老闆] 正在考慮: 升級伺服器 (15000元)
// 2. 拒絕 升級伺服器
// [代理] 小額費用自動批准
// 3. true
// [代理] 轉交老闆審批...
// [真老闆 王老闆] 審批費用: 2000元
// 4. true
// 5. 自動批准 購買新辦公椅
```

## 生存技巧 🛡️

1. **Proxy 設計原則**：

   - **透明性**：代理應該提供與真實物件相同的介面
   - **效能優化**：添加快取、延遲載入等機制
   - **權限控制**：實現適當的存取控制邏輯
   - **日誌監控**：記錄重要的操作和存取

2. **與老闆溝通策略**：

   - **授權範圍**：明確定義代理的決策權限
   - **回報機制**：建立清楚的升級和回報流程
   - **效率說明**：展示代理如何提高決策效率
   - **風險控制**：說明代理如何降低操作風險

3. **技術實作要點**：

   - **快取策略**：合理設計快取過期和清除機制
   - **權限檢查**：實現細粒度的權限控制
   - **錯誤處理**：優雅處理真實物件不可用的情況
   - **監控指標**：添加效能和使用情況監控

4. **架構決策建議**：
   - **代理層級**：避免過多層級的代理套疊
   - **狀態同步**：確保代理與真實物件的狀態一致
   - **效能考量**：代理不應該成為系統瓶頸
   - **安全性**：保護真實物件免受不當存取

## 明日預告 🔮

明天我們將探討 **Composite Pattern - 組織架構師**，學習如何應對老闆的階層管理哲學：「雖然有 PM，但是工程師也要會管專案嘛！」

準備迎接更複雜的組織結構挑戰！ 🎯
