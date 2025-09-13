# Day 13: Bridge Pattern - 橋梁工程師

## 老闆語錄 💬

> "介面要統一，但實作要多元！我要在手機上、電腦上、平板上都能用同樣的方式操作！"

## 災難現場 🔥

週一早上的產品會議，老闆拿著他的新 iPhone、MacBook 和 iPad 走進會議室，桌上一字排開像是要開科技展示會。

「我昨天想到一個問題！」老闆興奮地說，「我們的系統在不同平台上操作都不一樣！在手機上要滑動，在電腦上要點擊，在平板上又不一樣！」

UI 設計師小莉解釋：「因為每個平台的特性不同啊，手機螢幕小，電腦有鍵盤滑鼠...」

「我不管！」老闆打斷，「我要統一的操作邏輯！不管在哪個裝置上，『新增用戶』就是『新增用戶』，『查看報表』就是『查看報表』！我不要因為換個裝置就要重新學習！」

前端主管阿傑困惑地說：「但是實作方式完全不同啊，iOS 用 Swift，Android 用 Kotlin，Web 用 JavaScript...」

「那就做一個橋樑！」老闆在白板上畫了一座橋，「業務邏輯在橋的這一邊，技術實作在橋的那一邊！不管下面是什麼技術，上面的操作都要一樣！」

他繼續畫圖：「你看，『發送通知』這個功能，在手機上可能是推播，在電腦上可能是彈窗，在網頁上可能是訊息條。但是對使用者來說，都是『發送通知』！」

後端工程師小王提出疑問：「這樣不會很難維護嗎？」

「相反！」老闆眼神發亮，「這樣才好維護！當我們要新增一個新裝置，比如智慧手錶，我們只要實作手錶版本的『發送通知』，但業務邏輯完全不用改！」

你漸漸明白，老闆是在描述 **Bridge Pattern** - **將抽象部分與實作部分分離，使它們可以獨立變化**！

老闆最後總結：「我們要成為『跨平台統一大師』！一套邏輯，多種實作！」

## 模式解析 🧠

Bridge Pattern（橋接模式）是結構型設計模式中的分離大師，它的核心思想是：**將抽象部分與實作部分分離，使它們都可以獨立地變化**。

在我們的跨平台災難中，老闆的統一需求完美地展現了 Bridge Pattern 的本質：

1. **抽象與實作分離**：業務邏輯與平台實作獨立
2. **獨立變化**：新增平台或修改邏輯都不互相影響
3. **介面統一**：不同實作提供相同的抽象介面
4. **擴展性強**：容易新增新的抽象或新的實作

Bridge Pattern 的核心組件：

- **Abstraction**：定義抽象介面，維護對實作的引用
- **RefinedAbstraction**：擴展抽象介面的具體類別
- **Implementor**：定義實作介面
- **ConcreteImplementor**：具體實作類別

適用情境：

- **跨平台開發**：統一的 API 對應不同平台實作
- **驅動程式設計**：統一的硬體介面對應不同驅動
- **資料庫抽象**：統一的資料存取介面對應不同資料庫
- **通知系統**：統一的通知介面對應不同通知方式

## 程式碼範例 💻

讓我們實作一個「跨平台通知系統」，展示 Bridge Pattern 的核心概念：

```ts
// 實作介面：定義所有平台都要實作的方法
interface NotificationImplementor {
  sendNotification(title: string, message: string): void;
  showProgress(percentage: number): void;
  playSound(soundType: string): void;
}

// 具體實作 1：手機平台
class MobileNotification implements NotificationImplementor {
  sendNotification(title: string, message: string): void {
    console.log(`[手機推播] ${title}: ${message}`);
    console.log("📱 振動提醒");
  }

  showProgress(percentage: number): void {
    console.log(`[手機] 在狀態列顯示進度: ${percentage}%`);
  }

  playSound(soundType: string): void {
    console.log(`[手機] 播放系統音效: ${soundType}`);
  }
}

// 具體實作 2：桌面平台
class DesktopNotification implements NotificationImplementor {
  sendNotification(title: string, message: string): void {
    console.log(`[桌面彈窗] ${title}\n內容: ${message}`);
    console.log("💻 閃爍工作列圖示");
  }

  showProgress(percentage: number): void {
    const progressBar =
      "=".repeat(percentage / 10) + "-".repeat(10 - percentage / 10);
    console.log(`[桌面] 進度條: [${progressBar}] ${percentage}%`);
  }

  playSound(soundType: string): void {
    console.log(`[桌面] 播放 WAV 音效: ${soundType}.wav`);
  }
}

// 具體實作 3：網頁平台
class WebNotification implements NotificationImplementor {
  sendNotification(title: string, message: string): void {
    console.log(`[網頁彈出] 🔔 ${title}`);
    console.log(`[網頁] 顯示訊息條: ${message}`);
  }

  showProgress(percentage: number): void {
    console.log(`[網頁] 更新進度 CSS: width: ${percentage}%`);
  }

  playSound(soundType: string): void {
    console.log(`[網頁] 播放 Audio 標籤音效: ${soundType}`);
  }
}

// 抽象類別：定義業務邏輯介面
abstract class NotificationService {
  protected implementor: NotificationImplementor;

  constructor(implementor: NotificationImplementor) {
    this.implementor = implementor;
  }

  abstract notify(title: string, message: string): void;
  abstract updateProgress(percentage: number): void;
}

// 具體抽象 1：一般通知服務
class BasicNotificationService extends NotificationService {
  notify(title: string, message: string): void {
    console.log(`\n=== 基本通知服務 ===`);
    this.implementor.sendNotification(title, message);
  }

  updateProgress(percentage: number): void {
    this.implementor.showProgress(percentage);
  }
}

// 具體抽象 2：高級通知服務
class AdvancedNotificationService extends NotificationService {
  notify(title: string, message: string): void {
    console.log(`\n=== 高級通知服務 ===`);
    this.implementor.playSound("alert");
    this.implementor.sendNotification(title, message);
  }

  updateProgress(percentage: number): void {
    this.implementor.showProgress(percentage);
    if (percentage === 100) {
      this.implementor.playSound("complete");
      this.implementor.sendNotification("完成", "任務已完成！");
    }
  }

  // 額外功能：批量通知
  batchNotify(notifications: Array<{ title: string; message: string }>): void {
    console.log(`\n=== 批量通知 (${notifications.length} 則) ===`);
    notifications.forEach((notif, index) => {
      console.log(`\n通知 ${index + 1}:`);
      this.implementor.sendNotification(notif.title, notif.message);
    });
    this.implementor.playSound("batch_complete");
  }
}

// 使用範例
console.log("=== 老闆的跨平台統一通知系統 ===");

// 建立不同平台的實作
const mobileImpl = new MobileNotification();
const desktopImpl = new DesktopNotification();
const webImpl = new WebNotification();

// 建立不同的抽象服務
const basicMobile = new BasicNotificationService(mobileImpl);
const advancedDesktop = new AdvancedNotificationService(desktopImpl);
const advancedWeb = new AdvancedNotificationService(webImpl);

// 統一的業務操作，不同的平台實作
console.log("\n--- 基本通知測試 ---");
basicMobile.notify("新訊息", "您有一則新的私訊");

console.log("\n--- 高級通知測試 ---");
advancedDesktop.notify("系統更新", "發現新版本，請及時更新");

console.log("\n--- 進度更新測試 ---");
advancedWeb.updateProgress(50);
advancedWeb.updateProgress(100);

console.log("\n--- 批量通知測試 ---");
advancedDesktop.batchNotify([
  { title: "會議提醒", message: "10分鐘後開會" },
  { title: "任務到期", message: "專案即將到期" },
]);

// 輸出展示了相同的業務邏輯在不同平台上的不同實作
```

## 生存技巧 🛡️

1. **Bridge 設計原則**：

   - **單一職責**：抽象關注業務邏輯，實作關注技術細節
   - **開放封閉**：對擴展開放，對修改封閉
   - **介面穩定**：實作介面應該保持穩定，避免頻繁變動
   - **依賴倒置**：抽象不應該依賴具體實作

2. **與老闆溝通策略**：

   - **架構圖示**：用橋樑圖形象地展示抽象與實作的分離
   - **擴展性說明**：展示新增平台或功能的簡易性
   - **維護成本**：說明分離架構如何降低維護複雜度
   - **技術債務**：解釋如何避免平台特定的技術債務

3. **技術實作要點**：

   - **介面設計**：實作介面應該足夠抽象但不過度設計
   - **錯誤處理**：統一的錯誤處理機制跨越抽象和實作
   - **效能考量**：橋接層不應該成為效能瓶頸
   - **測試策略**：分別測試抽象邏輯和具體實作

4. **架構決策建議**：
   - **粒度控制**：避免過細或過粗的抽象分割
   - **版本管理**：實作介面的版本控制策略
   - **依賴注入**：使用 DI 容器管理實作的切換
   - **配置驅動**：通過配置文件選擇不同的實作

## 明日預告 🔮

明天我們將進行 **第二週總結 - 結構型模式防身術**，回顧我們學過的所有結構型模式，看看如何優雅地組合老闆的瘋狂想法！

準備迎接結構型模式的終極總結！ 🎯

