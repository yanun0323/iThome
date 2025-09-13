# Day 16: Strategy Pattern - 策略變色龍

## 老闆語錄 💬

> "這個季度用積極行銷策略，下季度改保守策略，年底看情況決定要不要用瘋狂促銷策略！"

## 災難現場 🔥

週二上午的季度策略會議，老闆站在投影機前，手裡拿著遙控器，螢幕上顯示著密密麻麻的營收圖表。

「各位！」老闆清了清嗓子，「我們的行銷策略需要更有『彈性』！」

行銷經理小萍舉手問：「什麼意思？」

「意思是...」老闆開始在白板上畫圖，「市場好的時候，我們用『積極攻勢策略』：大量投廣告，促銷活動，擴大市占率！」

他又畫了另一個圈：「市場不好的時候，我們用『保守防守策略』：減少支出，專注既有客戶，穩住基本盤！」

然後又畫了第三個圈：「遇到特殊節日，我們用『瘋狂促銷策略』：賠本賺吆喝，衝高知名度！」

財務經理老趙困惑地問：「那我們要怎麼知道什麼時候用哪種策略？」

「看情況啊！」老闆眼神發亮，「我希望系統能『智能切換』！市場指標好就自動切換到積極模式，指標差就切換到保守模式，遇到節日就切換到促銷模式！」

工程師小劉抗議：「但是每種策略的邏輯完全不同啊...」

「那就做成『策略模組』！」老闆越說越興奮，「就像換汽車引擎一樣！今天裝省油引擎，明天換大馬力引擎，後天換電動引擎！但是開車的方法都一樣！」

產品經理阿凱試圖理解：「所以您希望...」

「我希望我們的系統是『策略變色龍』！」老闆總結，「根據環境自動變色，但本質還是同一隻蜥蜴！」

你突然恍然大悟，老闆其實是在描述 **Strategy Pattern** - **定義一系列算法，把它們封裝起來，並且使它們可以互相替換**！

## 模式解析 🧠

Strategy Pattern（策略模式）是行為型設計模式中的變色大師，它的核心思想是：**定義一系列算法，把它們一個個封裝起來，並且使它們可以互相替換，此模式讓算法的變化獨立於使用算法的客戶端**。

在我們的策略災難中，老闆的變色龍需求完美地展現了 Strategy Pattern 的本質：

1. **算法族群**：多種行銷策略可以互換
2. **封裝變化**：每種策略獨立實作
3. **運行時切換**：根據情況動態選擇策略
4. **客戶端統一**：使用策略的方法保持一致

Strategy Pattern 的核心組件：

- **Strategy**：策略介面，定義所有支援的算法
- **ConcreteStrategy**：具體策略，實作特定算法
- **Context**：上下文，維護對策略物件的引用

適用情境：

- **多種算法選擇**：排序算法、壓縮算法、加密算法
- **業務規則變化**：定價策略、折扣計算、運費計算
- **條件分支過多**：替代大量的 if-else 或 switch-case
- **運行時決策**：根據配置或狀態選擇不同行為

## 程式碼範例 💻

讓我們實作一個「智能行銷策略系統」，展示 Strategy Pattern 的核心概念：

```ts
// 策略介面
interface Strategy {
  execute(data: number): number;
}

// 具體策略：積極策略
class AggressiveStrategy implements Strategy {
  execute(budget: number): number {
    return budget * 1.5; // 增加50%預算
  }
}

// 具體策略：保守策略
class ConservativeStrategy implements Strategy {
  execute(budget: number): number {
    return budget * 0.7; // 減少30%預算
  }
}

// 具體策略：促銷策略
class PromotionStrategy implements Strategy {
  execute(budget: number): number {
    return budget * 2.0; // 增加100%預算
  }
}

// 上下文類別
class Context {
  private strategy: Strategy;

  constructor(strategy: Strategy) {
    this.strategy = strategy;
  }

  setStrategy(strategy: Strategy): void {
    this.strategy = strategy;
  }

  executeStrategy(budget: number): number {
    return this.strategy.execute(budget);
  }
}

// 使用範例
const context = new Context(new ConservativeStrategy());

console.log("保守策略:", context.executeStrategy(1000)); // 700

context.setStrategy(new AggressiveStrategy());
console.log("積極策略:", context.executeStrategy(1000)); // 1500

context.setStrategy(new PromotionStrategy());
console.log("促銷策略:", context.executeStrategy(1000)); // 2000
```

## 生存技巧 🛡️

1. **Strategy 設計原則**：

   - **策略封裝**：每個策略都是獨立的算法實作
   - **可替換性**：策略之間可以自由切換
   - **擴展性**：容易添加新策略，遵循開放封閉原則
   - **職責分離**：上下文負責選擇，策略負責執行

2. **與老闆溝通策略**：

   - **變化應對**：展示系統如何快速適應市場變化
   - **成本控制**：說明策略切換如何優化成本
   - **風險分散**：解釋多策略如何降低單一依賴風險
   - **數據驅動**：強調基於數據自動選擇最佳策略

3. **技術實作要點**：

   - **策略選擇邏輯**：設計清晰的策略選擇機制
   - **狀態維護**：考慮策略切換時的狀態保持
   - **效能優化**：避免頻繁創建策略物件
   - **配置管理**：支援通過配置動態載入策略

4. **架構決策建議**：
   - **策略註冊機制**：實作策略的動態註冊和發現
   - **參數化策略**：支援策略參數的動態配置
   - **策略組合**：考慮多策略組合使用的可能性
   - **監控和分析**：記錄策略使用情況和效果分析

## 明日預告 🔮

明天我們將探討 **Command Pattern - 指令歷史學家**，學習如何應對老闆的反悔天賦：「我說過的話你都要記住，而且要能撤回！」

準備迎接可撤銷操作的挑戰！ ⏪



