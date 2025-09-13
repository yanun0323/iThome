# Day 3: Singleton Pattern - 獨裁者養成記

## 老闆語錄 💬

> "公司只能有一個我，所有決定都要經過我！"

## 災難現場 🔥

週三下午 3 點，你正在享受難得的寧靜時光，突然老闆的聲音從會議室傳來：「我發現問題了！」

你的心跳又開始不規律，因為老闆的「發現」通常意味著你的週末泡湯了。

「為什麼專案進度會這麼亂？」老闆走向白板，開始畫起組織圖，「原來是因為太多人在做決定！從今天開始，所有的專案決策都要經過我！」

設計師小美弱弱地舉手：「那如果你在開會怎麼辦？」

「那就等我開完會！」老闆理直氣壯地說，「公司只能有一個決策中心，就是我！所有的審批、所有的方向、所有的資源分配，都要我說了算！」

工程師阿明嘗試反駁：「但這樣效率會很差耶...」

「效率？統一性比效率重要！」老闆眼神堅定，「我們要的是一致性，不是速度。寧可慢一點，也不能亂。而且，」老闆停頓了一下，「你們知道為什麼我能當老闆嗎？因為我有全局觀！只有我能確保公司朝正確的方向前進！」

此時此刻，你突然領悟到一個深刻的道理：老闆不是在搞獨裁，他是在無意識地教授我們 **Singleton Pattern** 的真諦 - **確保系統中只有一個實例，並提供全局訪問點**。

老闆繼續說：「對了，我要一個系統來管理所有的審批流程，但記住 - 只能有一個審批者，就是我！不能有人繞過我直接決定事情！」

## 模式解析 🧠

Singleton Pattern（單例模式）是設計模式中的控制狂代表，它的核心思想是：**確保一個類別只有一個實例，並提供全局訪問該實例的方法**。

在我們的職場災難中，老闆的獨裁特性完美地展現了為什麼需要 Singleton Pattern：

1. **唯一性保證**：系統中只能有一個決策者（老闆）
2. **全局訪問**：所有人都能找到這個決策者
3. **狀態一致性**：所有決策都基於同一個狀態
4. **資源控制**：避免多個實例造成的資源浪費

Singleton Pattern 適用於以下情境：

- **配置管理器**：系統配置只能有一份
- **日誌記錄器**：避免多個記錄器造成文件衝突
- **資料庫連接池**：控制連接數量
- **快取管理器**：確保快取的一致性

但是要小心！就像老闆的獨裁會造成效率問題一樣，過度使用 Singleton 也會帶來問題：

- **測試困難**：全局狀態難以隔離測試
- **隱藏依賴**：程式碼依賴關係不明確
- **擴展性差**：未來如果需要多個實例會很麻煩
- **線程安全**：多線程環境下需要額外處理

## 程式碼範例 💻

讓我們來實作一個「老闆審批系統」，展示 Singleton Pattern 的威力：

```ts
// BossApproval 老闆審批系統 - Singleton Pattern 核心實作
class BossApproval {
  // 1. 私有靜態實例變數
  private static instance: BossApproval | null = null;

  // 2. 私有建構子 - 防止外部直接創建實例
  private constructor() {
    console.log("老闆審批系統初始化！只能有一個老闆！");
  }

  // 3. 公開靜態方法 - 獲取唯一實例
  public static getInstance(): BossApproval {
    if (BossApproval.instance === null) {
      BossApproval.instance = new BossApproval();
    }
    return BossApproval.instance;
  }

  // 4. 業務方法
  public approve(request: string): string {
    return `老闆批准了：${request}`;
  }

  public reject(request: string): string {
    return `老闆拒絕了：${request}`;
  }
}

// 使用範例
function demonstrateSingleton(): void {
  console.log("Singleton Pattern 核心概念展示");
  console.log("==============================");

  // 嘗試獲取實例 - 第一次會創建
  const boss1 = BossApproval.getInstance();
  console.log("第一次獲取老闆實例");

  // 再次獲取實例 - 返回相同實例
  const boss2 = BossApproval.getInstance();
  console.log("第二次獲取老闆實例");

  // 驗證是否為同一個實例
  console.log(`是否為同一個老闆？${boss1 === boss2}`); // true

  // 使用業務方法
  console.log(boss1.approve("購買辦公用品"));
  console.log(boss2.reject("無限預算申請"));
}

// 錯誤示範：無法直接創建實例
// const boss = new BossApproval(); // ❌ 編譯錯誤：Constructor is private
```

## 生存技巧 🛡️

1. **明智使用 Singleton**：不是所有東西都需要單例，只有真正需要全局唯一的才用
2. **線程安全考慮**：在多線程環境下要確保 Singleton 的創建是線程安全的
3. **避免隱藏依賴**：明確標示哪些地方使用了 Singleton
4. **預留後路**：設計時考慮未來可能需要多個實例的情況
5. **測試友善**：提供重置或清理 Singleton 狀態的方法供測試使用

## 明日預告 🔮

**Builder Pattern - 需求疊疊樂**，探討老闆的經典台詞：「我要免費的，但要比付費版更好用！」

準備迎接老闆貪心指數爆表的需求建構術吧！
