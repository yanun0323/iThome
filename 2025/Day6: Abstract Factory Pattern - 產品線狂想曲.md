# Day 6: Abstract Factory Pattern - 產品線狂想曲

## 老闆語錄 💬

> "B2B、B2C、C2C、我們還要做 A2Z！"

## 災難現場 🔥

週一早上，你剛坐下準備開始新的一週，就發現會議室裡傳來激烈的討論聲。透過玻璃窗，你看到老闆正站在白板前，畫著一個超級複雜的市場分析圖。

好奇心驅使你走近會議室，只聽到老闆正在慷慨激昂地演講：

「我們的眼光不能只停留在一個市場！」老闆指著白板上密密麻麻的箭頭和方框，「企業客戶、個人消費者、平台商家，這些都是我們的目標！」

業務經理小王舉手提問：「那我們要分別開發不同的產品嗎？」

「當然！但是要有策略！」老闆眼神發亮，轉身在白板上又畫了一個表格，「B2B 版本要專業、有企業級功能；B2C 版本要簡單、好用；C2C 版本要社交化、互動性強！」

產品經理阿強皺眉：「這樣我們需要三個完全不同的團隊？」

「不不不！」老闆搖搖手指，「這就是重點！我們要建立一個『萬能產品製造流水線』！不管客戶要什麼版本，我們都能快速生產出來！」

老闆繼續在白板上畫著架構圖：「UI 要有三套風格，後端要有三種配置，資料庫要有三個版本，連客服系統都要有三種話術！但核心技術是一樣的！」

此時你注意到老闆畫的圖，突然意識到他並不是在天馬行空，而是在直覺地描述 **Abstract Factory Pattern** 的概念 - **為創建一系列相關或相依的物件提供一個介面，而無需指定它們具體的類別**。

老闆最後總結：「我們要像汽車工廠一樣，同一條生產線可以生產經濟型、豪華型、運動型三種車，但每種車的引擎、內裝、外觀都是配套的！」

## 模式解析 🧠

Abstract Factory Pattern（抽象工廠模式）是創建型設計模式中的產品線統帥，它的核心思想是：**提供一個創建一系列相關或相依物件的介面，確保這些物件能夠協同工作**。

在我們的職場災難中，老闆的產品線擴張完美地展現了為什麼需要 Abstract Factory Pattern：

1. **產品族群概念**：B2B、B2C、C2C 每個都是完整的產品家族
2. **相依性管理**：同一族群內的產品需要協同工作
3. **風格一致性**：確保同族群產品的設計和行為一致
4. **擴展性需求**：未來可能還要支援 B2G、P2P 等新市場

Abstract Factory Pattern 適用於以下情境：

- **多產品族群**：系統需要支援多種相關產品的組合
- **平台相容性**：同一套邏輯需要在不同平台上運行
- **風格切換**：介面需要支援多種主題或風格
- **環境隔離**：開發、測試、正式環境使用不同配置

Abstract Factory Pattern 的優勢：

- **產品一致性**：確保同族群產品的相容性
- **易於擴展**：新增產品族群不影響現有程式碼
- **隔離具體類別**：客戶端不需要知道具體實作
- **統一管理**：所有產品創建邏輯集中管理

## 程式碼範例 💻

讓我們來實作一個簡化的「產品線工廠」，展示 Abstract Factory Pattern 的核心概念：

```ts
// 抽象產品介面 - 定義產品族群的契約
interface UI {
  render(): string;
}

interface Database {
  connect(): string;
}

// B2B 產品族群
class B2BUI implements UI {
  render(): string {
    return "企業級儀表板";
  }
}

class B2BDatabase implements Database {
  connect(): string {
    return "PostgreSQL 企業版";
  }
}

// B2C 產品族群
class B2CUI implements UI {
  render(): string {
    return "消費者友善介面";
  }
}

class B2CDatabase implements Database {
  connect(): string {
    return "MongoDB 雲端版";
  }
}

// 抽象工廠介面
interface ProductFactory {
  createUI(): UI;
  createDatabase(): Database;
}

// 具體工廠實作
class B2BFactory implements ProductFactory {
  createUI(): UI {
    return new B2BUI();
  }

  createDatabase(): Database {
    return new B2BDatabase();
  }
}

class B2CFactory implements ProductFactory {
  createUI(): UI {
    return new B2CUI();
  }

  createDatabase(): Database {
    return new B2CDatabase();
  }
}

// 使用範例
function createProductLine(type: string): ProductFactory {
  switch (type) {
    case "B2B":
      return new B2BFactory();
    case "B2C":
      return new B2CFactory();
    default:
      throw new Error("未知產品線");
  }
}

// 展示使用
const b2bFactory = createProductLine("B2B");
const ui = b2bFactory.createUI();
const db = b2bFactory.createDatabase();

console.log(`${ui.render()} + ${db.connect()}`);
// 輸出：企業級儀表板 + PostgreSQL 企業版
```

## 生存技巧 🛡️

1. **族群規劃清晰**：確保每個產品族群的界線和特性明確定義
2. **介面設計統一**：所有產品族群應該遵循相同的介面契約
3. **擴展機制**：預留新增產品族群的擴展點
4. **相依性管理**：確保同族群產品之間的相容性
5. **現實期望設定**：向老闆解釋為什麼不能真的做到「A2Z」全覆蓋

## 明日預告 🔮

**第一週總結 - 創建型模式求生指南**，回顧這週學到的所有創建型模式，並分享實戰經驗！

準備迎接創建型模式的完整武器庫總結吧！
