# Day 18: State Pattern - 心情氣象台

## 老闆語錄 💬

> "我心情好的時候什麼都好說，心情不好時免談！你們要學會看我的臉色行事，系統也要懂得察言觀色！"

## 災難現場 🔥

週四下午 2 點，辦公室裡瀰漫著緊張的氣氛。老闆剛從一個不順利的客戶會議回來，臉色陰沉如烏雲。

「為什麼客戶投訴處理系統還沒做好？」老闆重重地放下包包。

產品經理小美戰戰兢兢地說：「我們按照您上週的指示...」

「上週？」老闆眉頭緊皺，「上週我心情不好，說的話不算數！」

系統分析師小莉困惑地問：「那...我們要怎麼知道什麼時候您的話算數？」

老闆停頓了一下，突然眼神發亮：「對啊！這就是問題！你們要建立一個『老闆心情預測系統』！」

他開始在白板上畫圖：「我的心情有不同狀態：開心、生氣、焦慮、興奮...每種心情下，我對同一件事的反應完全不同！」

「比如說...」老闆指著圖，「開心時，你們提加薪我會說『好啊好啊』；生氣時，同樣的請求我會說『想都別想』；焦慮時，我會說『現在別煩我』；興奮時，我甚至會說『不如直接升職』！」

前端工程師小李弱弱地問：「那系統要怎麼判斷您的心情？」

「根據指標啊！」老闆越說越興奮，「股價、營收、客戶滿意度、競爭對手動態...這些都會影響我的心情！系統要能『智能切換』我的決策模式！」

後端工程師阿強提出疑問：「但是每種心情的處理邏輯都不一樣...」

「這就是重點！」老闆拍手，「同樣是『員工請假』這件事：開心時我會批准並說『好好休息』；生氣時我會拒絕並說『現在太忙』；焦慮時我會延後並說『下個月再說』；興奮時我會批准並說『多休幾天沒關係』！」

財務主管老趙試圖理解：「所以您希望系統能...根據您的心情狀態調整反應？」

「對！」老闆總結，「系統要像『心情氣象台』一樣！能預測我的心情變化，並根據不同心情提供不同的決策建議！而且心情轉換要很自然，不能突然從開心跳到生氣！」

你突然明白了，老闆在描述 **State Pattern** - **允許物件在內部狀態改變時改變它的行為，物件看起來好像修改了它的類別**！

## 模式解析 🧠

State Pattern（狀態模式）是行為型設計模式中的變色龍，它的核心思想是：**當一個物件的內部狀態改變時，允許改變其行為，這個物件看起來像是改變了其類別**。

在我們的心情氣象台災難中，老闆的心情管理需求完美地展現了 State Pattern 的本質：

1. **狀態封裝**：每種心情都有獨立的行為邏輯
2. **狀態轉換**：心情會根據外部因素自然切換
3. **行為變化**：同一操作在不同狀態下有不同反應
4. **透明切換**：外部無需知道當前是哪種狀態

State Pattern 的核心組件：

- **Context**：上下文，維護一個狀態實例並定義客戶端介面
- **State**：抽象狀態，定義一個介面以封裝特定狀態的行為
- **ConcreteState**：具體狀態，每個子類別實作一個與Context的狀態相關的行為

適用情境：

- **狀態機實作**：有限狀態機的程式實現
- **條件行為**：物件行為依賴於狀態的場景
- **狀態轉換**：複雜的狀態轉換邏輯
- **工作流程**：業務流程中的狀態管理

## 程式碼範例 💻

讓我們實作一個「老闆心情管理系統」，展示 State Pattern 的核心概念：

```ts
// 抽象狀態
abstract class BossState {
  abstract handleRequest(request: string): string;
  abstract getStateName(): string;
}

// 上下文：老闆心情管理系統
class BossContext {
  private currentState: BossState = new NormalState();

  setState(state: BossState): void {
    console.log(`🔄 心情轉換: ${this.currentState.getStateName()} → ${state.getStateName()}`);
    this.currentState = state;
  }

  processRequest(request: string): string {
    console.log(`😊 當前心情: ${this.currentState.getStateName()}`);
    return this.currentState.handleRequest(request);
  }

  // 根據業務指標調整心情
  updateMood(stockPrice: number, satisfaction: number): void {
    if (stockPrice > 120 && satisfaction > 80) {
      this.setState(new HappyState());
    } else if (stockPrice < 80 || satisfaction < 60) {
      this.setState(new AngryState());
    } else {
      this.setState(new NormalState());
    }
  }
}

// 具體狀態：正常心情
class NormalState extends BossState {
  handleRequest(request: string): string {
    if (request.includes("請假")) return "好的，記得好好休息";
    if (request.includes("加薪")) return "我們來討論一下具體數字";
    return "聽起來還不錯，繼續努力";
  }

  getStateName(): string {
    return "😐 正常";
  }
}

// 具體狀態：開心心情
class HappyState extends BossState {
  handleRequest(request: string): string {
    if (request.includes("請假")) return "當然可以！多休息幾天都沒問題！";
    if (request.includes("加薪")) return "好啊好啊！你們都很棒！";
    return "太棒了！我今天心情特別好！";
  }

  getStateName(): string {
    return "😊 開心";
  }
}

// 具體狀態：生氣心情
class AngryState extends BossState {
  handleRequest(request: string): string {
    if (request.includes("請假")) return "現在這麼忙還想請假？想都別想！";
    if (request.includes("加薪")) return "業績都這樣了還想加薪？";
    return "我現在沒心情處理這個！";
  }

  getStateName(): string {
    return "😠 生氣";
  }
}

// 使用範例
const boss = new BossContext();

// 測試正常狀態
console.log("=== 正常狀態 ===");
console.log(boss.processRequest("我想請假"));
console.log(boss.processRequest("希望能加薪"));

// 業績好轉，老闆開心
console.log("\n=== 業績大好！ ===");
boss.updateMood(130, 85);
console.log(boss.processRequest("我想請假"));
console.log(boss.processRequest("希望能加薪"));

// 業績下滑，老闆生氣
console.log("\n=== 業績不佳... ===");
boss.updateMood(70, 50);
console.log(boss.processRequest("我想請假"));
console.log(boss.processRequest("希望能加薪"));
```

## 生存技巧 🛡️

1. **State 設計原則**：

   - **狀態封裝**：每個狀態類別封裝特定狀態的行為
   - **轉換邏輯**：狀態轉換邏輯可在狀態內部或上下文中
   - **介面一致**：所有狀態類別實作相同介面
   - **單一職責**：每個狀態只處理特定行為

2. **與老闆溝通策略**：

   - **情緒智商**：展示系統能理解情境變化
   - **適應能力**：說明如何根據情況調整反應
   - **預測功能**：強調能預測狀態變化趨勢
   - **一致體驗**：保證用戶體驗的連續性

3. **技術實作要點**：

   - **狀態機設計**：明確定義狀態轉換圖
   - **記憶體管理**：考慮狀態物件的生命週期
   - **執行緒安全**：多執行緒環境下的狀態一致性
   - **狀態持久化**：需要時保存和恢復狀態

4. **架構決策建議**：
   - **狀態數量**：避免過多狀態導致複雜性爆炸
   - **轉換觸發**：設計清晰的狀態轉換觸發機制
   - **錯誤處理**：處理無效狀態轉換的情況
   - **監控日誌**：記錄狀態轉換歷史以便除錯

## 明日預告 🔮

明天我們將探討 **Template Method Pattern - 流程控制狂**，學習如何應對老闆的程序化思維：「流程是固定的，但細節你們各部門自己決定！」

準備迎接算法框架的挑戰！ 📋
