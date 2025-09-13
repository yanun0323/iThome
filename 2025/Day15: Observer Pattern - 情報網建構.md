# Day 15: Observer Pattern - 情報網建構

## 老闆語錄 💬

> "有任何風吹草動都要立刻回報給我！銷售數據變動要通知，用戶投訴要通知，連伺服器 CPU 使用率也要通知！"

## 災難現場 🔥

週一早上 8:30，你剛打開電腦準備開始一天的工作，老闆就衝進辦公室，手裡拿著印滿數字的報表。

「昨天週末發生了什麼事？」老闆氣急敗壞地問，「銷售額掉了 5%，我竟然到現在才知道！」

數據分析師小陳無辜地說：「我週末沒上班啊...」

「這就是問題！」老闆在白板上畫了一個大圓圈，把自己放在中心，「我要建立一個『即時情報網』！不管發生什麼事，我都要第一時間知道！」

他開始瘋狂畫箭頭：「銷售數據有變化 → 立刻通知我！用戶有投訴 → 馬上報告！伺服器有問題 → 緊急聯絡！股價波動 → 即時更新！甚至連辦公室咖啡機沒水了都要告訴我！」

系統管理員老李困惑地問：「那我們要一直監控這些資料嗎？」

「不是你們監控！」老闆興奮地說，「是系統自動監控！我要一個『智能監視系統』，當任何指標超過閾值，系統就自動發通知給所有相關人員！」

產品經理小王提出疑問：「但是不同的事件需要通知不同的人啊...」

「對！」老闆眼神發亮，「銷售問題通知業務部，技術問題通知工程師，財務問題通知會計！系統要知道『誰該收到什麼通知』！」

你突然意識到，老闆是在描述 **Observer Pattern** - **當一個物件的狀態發生改變時，所有依賴它的物件都得到通知並自動更新**！

老闆最後總結：「我們要成為『全知全能的情報中心』！一有風吹草動，相關人員立刻行動！」

## 模式解析 🧠

Observer Pattern（觀察者模式）是行為型設計模式中的資訊大師，它的核心思想是：**定義物件間的一對多依賴關係，當一個物件的狀態發生改變時，所有依賴於它的物件都得到通知並被自動更新**。

在我們的情報網災難中，老闆的監控需求完美地展現了 Observer Pattern 的本質：

1. **事件發佈**：系統狀態變化時自動通知
2. **訂閱機制**：相關人員訂閱感興趣的事件
3. **自動更新**：狀態改變時，觀察者自動收到通知
4. **鬆散耦合**：被觀察者不需要知道觀察者的細節

Observer Pattern 的核心組件：

- **Subject (主題)**：被觀察的物件，維護觀察者列表
- **Observer (觀察者)**：定義接收通知的介面
- **ConcreteSubject**：具體主題，狀態改變時通知觀察者
- **ConcreteObserver**：具體觀察者，實作更新方法

適用情境：

- **事件驅動系統**：GUI 事件處理、遊戲事件系統
- **資料監控**：股價監控、系統監控、業務指標追蹤
- **MVC 架構**：Model 變化通知 View 更新
- **發佈-訂閱系統**：消息隊列、通知系統

## 程式碼範例 💻

讓我們實作一個「企業情報監控系統」，展示 Observer Pattern 的核心概念：

```ts
// 觀察者介面
interface Observer {
  update(data: string): void;
}

// 主題介面
interface Subject {
  addObserver(observer: Observer): void;
  removeObserver(observer: Observer): void;
  notifyObservers(): void;
}

// 具體主題：資料監控
class DataMonitor implements Subject {
  private observers: Observer[] = [];
  private data: string = "";

  addObserver(observer: Observer): void {
    this.observers.push(observer);
  }

  removeObserver(observer: Observer): void {
    const index = this.observers.indexOf(observer);
    if (index > -1) {
      this.observers.splice(index, 1);
    }
  }

  notifyObservers(): void {
    this.observers.forEach(observer => observer.update(this.data));
  }

  setData(data: string): void {
    this.data = data;
    this.notifyObservers(); // 狀態改變時自動通知
  }
}

// 具體觀察者：老闆
class Boss implements Observer {
  update(data: string): void {
    console.log(`👔 老闆收到通知: ${data}`);
  }
}

// 具體觀察者：經理
class Manager implements Observer {
  update(data: string): void {
    console.log(`👨‍💼 經理收到通知: ${data}`);
  }
}

// 使用範例
const monitor = new DataMonitor();
const boss = new Boss();
const manager = new Manager();

// 建立觀察關係
monitor.addObserver(boss);
monitor.addObserver(manager);

// 觸發通知
monitor.setData("銷售額下降5%");
monitor.setData("系統CPU過高");
```

## 生存技巧 🛡️

1. **Observer 設計原則**：

   - **鬆散耦合**：主題和觀察者之間保持最小依賴
   - **開放封閉**：容易添加新觀察者，無需修改現有代碼
   - **單一職責**：每個觀察者只關注自己相關的事件
   - **避免循環依賴**：觀察者不應該反過來修改主題

2. **與老闆溝通策略**：

   - **即時性強調**：展示系統如何提供即時反饋
   - **責任分散**：說明不同事件如何找到對應負責人
   - **擴展性說明**：展示如何輕易添加新的監控項目
   - **自動化價值**：強調減少人工監控的成本

3. **技術實作要點**：

   - **效能考量**：避免觀察者過多影響通知效能
   - **錯誤隔離**：一個觀察者的錯誤不應影響其他觀察者
   - **記憶體管理**：注意觀察者的生命週期管理
   - **通知順序**：考慮是否需要保證通知的順序

4. **架構決策建議**：
   - **推拉模式選擇**：推送全部資料 vs 觀察者主動拉取
   - **同步 vs 異步**：同步通知 vs 異步事件處理
   - **事件過濾**：實作事件過濾機制避免無用通知
   - **監控監控者**：對觀察者本身進行監控和管理

## 明日預告 🔮

明天我們將探討 **Strategy Pattern - 策略變色龍**，學習如何應對老闆的多重人格決策：「這個季度用 A 方案，下季度用 B 方案，看心情決定！」

準備迎接策略切換的挑戰！ 🎯

