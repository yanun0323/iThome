# Day 24: Memento Pattern - 時光倉庫管理員

## 老闆語錄 💬

> "把每個版本都保存起來！上午的版本、下午的版本、我心情好時的版本、我心情不好時的版本，說不定哪天我又想要舊版本了！"

## 災難現場 🔥

週三上午 10 點，你正在專心寫程式，老闆突然衝到你桌前，臉色慌張。

「快！快把系統改回昨天的版本！」老闆急得跺腳。

你困惑地問：「為什麼？新版本不是已經上線了嗎？」

「客戶說不喜歡新介面！」老闆抓著頭髮，「他們要舊版本的感覺，但要保留新功能！」

你翻了翻 Git 記錄：「可是...我們已經把很多東西合併了...」

「什麼叫合併？」老闆更慌了，「你不是說會保存每個版本嗎？」

這時候，產品經理小美也湊過來：「我們還需要上個月的報表格式，但要用這個月的數據...」

設計師阿凱也加入：「老闆昨天說要用第三版的設計，今天又說要第一版的顏色配第二版的布局...」

老闆聽得頭更大了：「為什麼不能有一個『時光機』？我想要什麼時候的版本就能立刻拿到？」

系統分析師老張嘆氣：「那我們要建一個『版本倉庫』嗎？」

「對！」老闆眼神發亮，「我要一個『時光倉庫』！每次有重要改動，就自動保存一個快照！我想要什麼時候的狀態，就能立刻恢復！」

他開始在白板上畫圖：「而且這個倉庫要很聰明！知道什麼時候該保存，保存哪些資料，還要能夠完美還原！」

前端工程師小李疑惑地問：「但是每個版本的內部結構可能都不一樣啊...」

「這就是重點！」老闆越說越興奮，「系統不能知道我們存了什麼，但要能完美復原！就像『記憶膠囊』一樣！把當時的狀態完整封裝，需要的時候再完整取出！」

你突然恍然大悟，老闆在描述 **Memento Pattern** - **在不破壞封裝的前提下，捕獲一個物件的內部狀態，並在該物件之外保存這個狀態**！

## 模式解析 🧠

Memento Pattern（備忘錄模式）是行為型設計模式中的時光守護者，它的核心思想是：**在不違反封裝原則的前提下，捕獲並外部化一個物件的內部狀態，以便之後能將該物件恢復到原先保存的狀態**。

在我們的時光旅行災難中，老闆的版本管理需求完美地展現了 Memento Pattern 的本質：

1. **狀態捕獲**：保存物件在特定時刻的完整狀態
2. **封裝保護**：不暴露物件的內部實作細節
3. **狀態恢復**：能夠將物件恢復到之前的狀態
4. **時光旅行**：支援多個時間點的狀態管理

Memento Pattern 的核心組件：

- **Originator**：原發器，創建備忘錄並使用備忘錄恢復狀態
- **Memento**：備忘錄，存儲原發器的內部狀態
- **Caretaker**：負責人，管理備忘錄但不操作其內容

適用情境：

- **撤銷操作**：文字編輯器、圖形編輯器的 Undo 功能
- **檢查點系統**：遊戲存檔、交易回滾、系統備份
- **狀態快照**：配置管理、工作流狀態保存
- **歷史記錄**：瀏覽器歷史、操作記錄追蹤

## 程式碼範例 💻

讓我們實作一個「專案狀態時光機」，展示 Memento Pattern 的核心概念：

```ts
// 備忘錄：專案狀態快照
class ProjectMemento {
  constructor(private readonly snapshot: any) {}

  getSnapshot(): any {
    return { ...this.snapshot }; // 深拷貝保護
  }
}

// 原發器：專案管理系統
class ProjectManager {
  private features: string[] = [];
  private version: string = "1.0.0";

  addFeature(feature: string): void {
    this.features.push(feature);
    this.updateVersion();
    console.log(`✅ 添加功能: ${feature} (版本: ${this.version})`);
  }

  removeFeature(feature: string): void {
    const index = this.features.indexOf(feature);
    if (index > -1) {
      this.features.splice(index, 1);
      this.updateVersion();
    }
  }

  private updateVersion(): void {
    const parts = this.version.split('.').map(Number);
    parts[2]++;
    this.version = parts.join('.');
  }

  // 創建備忘錄
  createMemento(): ProjectMemento {
    return new ProjectMemento({
      features: [...this.features],
      version: this.version
    });
  }

  // 從備忘錄恢復
  restoreFromMemento(memento: ProjectMemento): void {
    const snapshot = memento.getSnapshot();
    this.features = [...snapshot.features];
    this.version = snapshot.version;
    console.log(`🔄 恢復到版本: ${this.version}`);
  }

  showStatus(): void {
    console.log(`📊 版本: ${this.version}, 功能: ${this.features.join(', ') || '無'}`);
  }
}

// 負責人：版本管理器
class VersionManager {
  private mementos: Map<string, ProjectMemento> = new Map();

  saveSnapshot(name: string, project: ProjectManager): void {
    const memento = project.createMemento();
    this.mementos.set(name, memento);
    console.log(`💾 保存快照: ${name}`);
  }

  restoreSnapshot(name: string, project: ProjectManager): void {
    const memento = this.mementos.get(name);
    if (memento) {
      project.restoreFromMemento(memento);
    } else {
      console.log(`❌ 找不到快照: ${name}`);
    }
  }
}

// 使用範例
const project = new ProjectManager();
const versionManager = new VersionManager();

// 開發流程
project.addFeature("用戶登入");
project.addFeature("商品瀏覽");
versionManager.saveSnapshot("基礎版本", project);

project.addFeature("購物車");
versionManager.saveSnapshot("購物車版本", project);

project.showStatus();

// 老闆改變主意
console.log("\n👔 老闆: 恢復到基礎版本！");
versionManager.restoreSnapshot("基礎版本", project);
project.showStatus();
```

## 生存技巧 🛡️

1. **Memento 設計原則**：

   - **封裝保護**：備忘錄對外不透露原發器的內部結構
   - **窄介面**：負責人只能操作備忘錄的基本資訊
   - **寬介面**：原發器可以完全存取備忘錄內容
   - **狀態完整性**：確保保存的狀態足以完全恢復

2. **與老闆溝通策略**：

   - **時光旅行感**：強調能夠自由穿梭於不同版本
   - **安全保障**：說明任何操作都能安全回退
   - **記憶體管理**：解釋如何控制儲存空間
   - **操作簡便**：展示一鍵保存和恢復的便利

3. **技術實作要點**：

   - **深拷貝**：確保狀態保存的獨立性
   - **記憶體優化**：避免保存過多不必要的狀態
   - **序列化考慮**：複雜物件的狀態持久化
   - **版本兼容**：處理不同版本間的狀態差異

4. **架構決策建議**：
   - **儲存策略**：內存 vs 持久化儲存
   - **清理機制**：自動清理舊版本避免記憶體洩漏
   - **差異保存**：考慮只保存狀態差異以節省空間
   - **並行安全**：多執行緒環境下的狀態一致性

## 明日預告 🔮

明天我們將探討 **Iterator Pattern - 檢查狂魔**，學習如何應對老闆的強迫症檢查：「我要一個一個檢查，不能漏掉任何細節！」

準備迎接逐一巡禮的挑戰！ 🔍
