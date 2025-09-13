# Day 14: 第二週總結 - 結構型模式防身術

## 老闆語錄 💬

> "好！現在我們有了最強的系統架構！但是能不能再加個 AI、區塊鏈還有元宇宙功能？"

## 災難現場 🔥

週五下午的架構 review 會議，你剛向老闆展示了這週實作的各種結構型模式：Adapter 讓新舊系統完美整合，Decorator 為功能添加了無數裝飾，Facade 簡化了複雜的操作介面，Proxy 提供了完美的代理機制，Composite 建立了彈性的組織架構，Bridge 實現了跨平台統一。

「太棒了！」老闆興奮地拍手，「現在我們的系統已經很完美了！」

你正準備鬆一口氣，老闆突然眼神發亮：「但是啊...既然我們已經這麼厲害了，是不是應該再加點什麼？」

架構師老張警覺地問：「加什麼？」

「我想想...」老闆開始在白板上畫圖，「我們能不能在 Facade 裡面再包一個 Proxy，然後用 Decorator 加上區塊鏈功能，再用 Adapter 接上 AI 服務？」

前端主管小李試圖抗議：「這樣會不會太複雜？」

「不會啊！」老闆繼續畫，「你看，用戶透過 Facade 操作，Facade 內部用 Proxy 控制權限，Proxy 再用 Decorator 加上智能合約驗證，最後用 Adapter 轉接到元宇宙平台！完美的結構型模式組合技！」

PM 阿美頭痛地說：「但是這樣的複雜度...」

「這就是重點！」老闆得意地說，「複雜度藏在結構裡面，對使用者來說還是很簡單！這就是設計模式的威力！」

你突然意識到，老闆雖然常常提出瘋狂的需求，但他其實理解了結構型模式的真正價值：**用優雅的結構來管理複雜性**。

## 模式解析 🧠

經過這一週的洗禮，我們學會了結構型模式的六大武器。讓我們回顧一下這些「防身術」：

### 🔧 Adapter Pattern - 新舊系統媒合器

**核心價值**：讓不相容的介面能夠合作
**老闆翻譯**：「舊系統不要丟，新功能要能用」
**適用時機**：系統整合、第三方 API 接入、遺留系統現代化

### 🎨 Decorator Pattern - 功能收集狂

**核心價值**：動態地給物件添加職責，而不改變其結構
**老闆翻譯**：「功能要能隨意搭配，像樂高一樣」
**適用時機**：功能擴展、權限控制、中間件設計

### 🎮 Facade Pattern - 簡化大師

**核心價值**：為複雜子系統提供統一的簡化介面
**老闆翻譯**：「我不管後面多複雜，前面要很簡單」
**適用時機**：微服務整合、API 網關、系統封裝

### 👤 Proxy Pattern - 代理人生

**核心價值**：控制對其他物件的存取
**老闆翻譯**：「我不在的時候，你代替我做決定」
**適用時機**：權限控制、快取機制、遠端代理

### 🌳 Composite Pattern - 組織架構師

**核心價值**：統一處理個體物件和組合物件
**老闆翻譯**：「管一個人和管一群人的方法要一樣」
**適用時機**：階層管理、樹狀結構、統一操作

### 🌉 Bridge Pattern - 橋梁工程師

**核心價值**：將抽象部分與實作部分分離
**老闆翻譯**：「介面統一，實作多元」
**適用時機**：跨平台開發、驅動抽象、多實作切換

## 程式碼範例 💻

讓我們來看一個「結構型模式組合技」的實戰範例：

```ts
// 1. Bridge Pattern：跨平台通知基礎
interface NotificationPlatform {
  send(message: string): void;
}

class EmailPlatform implements NotificationPlatform {
  send(message: string): void {
    console.log(`📧 Email: ${message}`);
  }
}

class SMSPlatform implements NotificationPlatform {
  send(message: string): void {
    console.log(`📱 SMS: ${message}`);
  }
}

// 2. Decorator Pattern：添加功能裝飾
class NotificationDecorator {
  constructor(protected platform: NotificationPlatform) {}

  send(message: string): void {
    this.platform.send(message);
  }
}

class EncryptionDecorator extends NotificationDecorator {
  send(message: string): void {
    const encrypted = `🔐[Encrypted] ${message}`;
    super.send(encrypted);
  }
}

class LoggingDecorator extends NotificationDecorator {
  send(message: string): void {
    console.log(`📝 Log: Sending notification...`);
    super.send(message);
    console.log(`📝 Log: Notification sent`);
  }
}

// 3. Proxy Pattern：權限控制
class NotificationProxy {
  constructor(
    private target: NotificationDecorator,
    private userRole: string
  ) {}

  send(message: string): void {
    if (this.userRole === "admin") {
      this.target.send(message);
    } else {
      console.log(`❌ 權限不足，無法發送: ${message}`);
    }
  }
}

// 4. Adapter Pattern：整合舊系統
class LegacyNotificationSystem {
  sendOldFormat(msg: string, priority: number): void {
    console.log(`🏛️ Legacy: [P${priority}] ${msg}`);
  }
}

class LegacyAdapter implements NotificationPlatform {
  constructor(private legacy: LegacyNotificationSystem) {}

  send(message: string): void {
    this.legacy.sendOldFormat(message, 1);
  }
}

// 5. Composite Pattern：組合管理
class NotificationGroup {
  private notifications: NotificationProxy[] = [];

  add(notification: NotificationProxy): void {
    this.notifications.push(notification);
  }

  sendToAll(message: string): void {
    console.log(`📢 群發通知: ${message}`);
    this.notifications.forEach((notif) => notif.send(message));
  }
}

// 6. Facade Pattern：統一介面
class NotificationFacade {
  private emailGroup = new NotificationGroup();
  private smsGroup = new NotificationGroup();

  constructor() {
    this.setupNotifications();
  }

  private setupNotifications(): void {
    // 設定 Email 通知鏈
    const emailPlatform = new EmailPlatform();
    const encryptedEmail = new EncryptionDecorator(emailPlatform);
    const loggedEmail = new LoggingDecorator(encryptedEmail);
    const emailProxy = new NotificationProxy(loggedEmail, "admin");
    this.emailGroup.add(emailProxy);

    // 設定 SMS 通知鏈
    const smsPlatform = new SMSPlatform();
    const loggedSMS = new LoggingDecorator(smsPlatform);
    const smsProxy = new NotificationProxy(loggedSMS, "user");
    this.smsGroup.add(smsProxy);

    // 整合舊系統
    const legacy = new LegacyNotificationSystem();
    const legacyAdapter = new LegacyAdapter(legacy);
    const legacyDecorator = new LoggingDecorator(legacyAdapter);
    const legacyProxy = new NotificationProxy(legacyDecorator, "admin");
    this.emailGroup.add(legacyProxy);
  }

  // 老闆最愛的一鍵操作
  sendUrgentNotification(message: string): void {
    console.log("\n🚨 緊急通知系統啟動 🚨");
    this.emailGroup.sendToAll(message);
    this.smsGroup.sendToAll(message);
  }

  sendEmailOnly(message: string): void {
    console.log("\n📧 Email 通知");
    this.emailGroup.sendToAll(message);
  }
}

// 使用範例
console.log("=== 老闆的終極通知系統 ===");

const notificationSystem = new NotificationFacade();

// 一鍵發送緊急通知
notificationSystem.sendUrgentNotification("系統將於30分鐘後維護");

// 單獨發送 Email
notificationSystem.sendEmailOnly("月報已生成，請查收");
```

## 生存技巧 🛡️

### 1. 模式選擇指南

**當老闆說「要整合舊系統」→ 考慮 Adapter Pattern**
**當老闆說「功能要能隨意搭配」→ 考慮 Decorator Pattern**
**當老闆說「操作要很簡單」→ 考慮 Facade Pattern**
**當老闆說「我不在時你代理我」→ 考慮 Proxy Pattern**
**當老闆說「管理方式要統一」→ 考慮 Composite Pattern**
**當老闆說「介面統一實作多元」→ 考慮 Bridge Pattern**

### 2. 組合使用策略

- **Facade + Proxy**：統一介面 + 權限控制
- **Decorator + Adapter**：功能增強 + 系統整合
- **Bridge + Composite**：跨平台抽象 + 階層管理
- **所有模式組合**：企業級複雜系統

### 3. 避免過度設計

- **不要為了用模式而用模式**
- **先解決問題，再考慮模式**
- **保持代碼的可讀性和維護性**
- **記住：簡單的解決方案往往是最好的**

### 4. 與老闆溝通技巧

- **用視覺圖表展示結構**
- **強調維護成本的降低**
- **展示擴展性和彈性**
- **提供具體的效益數據**

## 週末作業 📚

1. **回顧本週學習的六種結構型模式**
2. **思考你目前專案中可以應用的場景**
3. **嘗試組合兩種或以上的模式解決實際問題**
4. **準備迎接下週的行為型模式挑戰**

## 明日預告 🔮

下週我們將進入 **行為型模式** 的世界！從 **Observer Pattern** 開始，學習如何應對老闆的監控妄想症：「有任何風吹草動都要立刻回報給我！」

行為型模式將教會我們如何優雅地處理物件間的溝通和協作，準備好迎接更多的職場心理戰！ 🧠💪

記住：**結構決定功能，行為決定價值**！

