# Day 5: Prototype Pattern - 抄襲有理

## 老闆語錄 💬

> "我們要開發跟 Google 一樣的搜尋引擎，但要比它快！"

## 災難現場 🔥

週五的技術會議上，老闆神秘兮兮地打開投影機，螢幕上出現了一份「機密市調報告」。

「各位同事，我花了整個晚上研究競爭對手，」老闆指著螢幕上密密麻麻的網站截圖，「我發現了一個重要趨勢！」

PM 阿華緊張地問：「什麼趨勢？」

「模仿是最高的讚美！」老闆眼神發亮，「你看，Facebook 學 Twitter 做了 Meta，Instagram 學 TikTok 做了 Reels，Netflix 學 Disney+ 做了更多原創內容！」

工程師小李困惑地說：「所以...我們要學什麼？」

「全部！」老闆激動地站起來，「我們要做一個搜尋引擎像 Google，社交功能像 Facebook，影片平台像 YouTube，購物體驗像 Amazon！」

設計師小美試圖理性討論：「但這樣不是抄襲嗎？」

「這叫做『創新致敬』！」老闆拍拍胸膛，「我們不是單純複製，我們是在現有的成功基礎上創造更好的版本！就像 iPhone 學習了所有手機的優點，然後變成最好的手機一樣！」

此時老闆走到白板前開始畫圖：「我們要建立一個『成功模式複製機』！輸入一個成功產品的特徵，輸出一個更好的版本！」

你看著老闆的示意圖，突然恍然大悟：他不是在教我們抄襲，而是在無意中展示 **Prototype Pattern** 的核心精神 - **通過複製現有物件來創建新物件，而不是從頭開始**。

## 模式解析 🧠

Prototype Pattern（原型模式）是創建型設計模式中的複製大師，它的核心思想是：**通過複製現有的物件（原型）來創建新物件，而非通過類別實例化**。

在我們的職場災難中，老闆的模仿策略完美地展現了為什麼需要 Prototype Pattern：

1. **避免重複創建**：不用從零開始設計，基於成功案例修改
2. **保持核心特徵**：複製已驗證的成功要素
3. **提高創建效率**：減少初始化的複雜程式
4. **動態配置**：可以在運行時決定要複製哪種原型

Prototype Pattern 適用於以下情境：

- **物件創建成本高**：初始化過程複雜或耗時
- **類別動態決定**：運行時才知道要創建哪種物件
- **避免子類爆炸**：減少為了創建物件而設計的子類
- **保持物件狀態**：需要保留物件當前的狀態配置

Prototype Pattern 的優勢：

- **效能提升**：複製比重新創建更快
- **靈活性**：可以在運行時添加或移除原型
- **減少子類**：避免平行的工廠類層次結構
- **配置保持**：保留複雜物件的內部狀態

## 程式碼範例 💻

讓我們來實作一個「競品複製系統」，展示 Prototype Pattern 的威力：

```ts
// 可複製介面
interface Cloneable<T> {
  clone(): T;
}

// 產品基類
abstract class Product implements Cloneable<Product> {
  constructor(public name: string, public features: string[] = []) {}

  abstract clone(): Product;

  getInfo(): string {
    return `${this.name}: ${this.features.join(", ")}`;
  }
}

// 搜尋引擎產品
class SearchEngine extends Product {
  constructor(
    name: string,
    features: string[] = [],
    public algorithm: string = "基礎搜尋"
  ) {
    super(name, features);
  }

  clone(): SearchEngine {
    return new SearchEngine(
      this.name + " 複製版",
      [...this.features], // 深度複製陣列
      this.algorithm
    );
  }

  getInfo(): string {
    return `${super.getInfo()} (演算法: ${this.algorithm})`;
  }
}

// 原型管理器
class PrototypeManager {
  private prototypes = new Map<string, Product>();

  register(key: string, prototype: Product): void {
    this.prototypes.set(key, prototype);
  }

  create(key: string): Product | null {
    const prototype = this.prototypes.get(key);
    return prototype?.clone() || null;
  }
}

// 使用範例
function demonstratePrototype(): void {
  const manager = new PrototypeManager();

  // 建立 Google 風格原型
  const googlePrototype = new SearchEngine(
    "Google搜尋",
    ["全文搜尋", "即時建議", "圖片搜尋"],
    "PageRank + AI"
  );

  // 註冊原型
  manager.register("google", googlePrototype);

  console.log("原型：", googlePrototype.getInfo());

  // 複製並客製化
  const ourSearch = manager.create("google") as SearchEngine;
  ourSearch.features.push("區塊鏈驗證", "AI助理");
  ourSearch.algorithm = "超越PageRank的神秘演算法";

  console.log("我們的版本：", ourSearch.getInfo());
  console.log("原型是否被影響：", googlePrototype.getInfo());
}

demonstratePrototype();
```

**核心重點**：

- **複製而非創建**：`clone()` 方法複製現有物件
- **深度複製**：陣列用 `[...array]` 避免參考問題
- **原型註冊**：`PrototypeManager` 管理可複用的原型
- **客製化**：複製後可以修改而不影響原型

## 生存技巧 🛡️

1. **深度複製實作**：確保物件的所有層級都被正確複製，避免淺複製問題
2. **註冊機制設計**：建立原型註冊中心，方便管理和使用各種原型
3. **合理借鑑策略**：向老闆解釋「借鑑」和「抄襲」的技術差異
4. **效能考量**：在物件創建成本高時才使用 Prototype Pattern
5. **法律風險評估**：確保「創新致敬」不會觸犯智慧財產權

## 明日預告 🔮

**Abstract Factory Pattern - 產品線狂想曲**，探討老闆的野心膨脹：「B2B、B2C、C2C、我們還要做 A2Z！」

準備迎接更瘋狂的產品族群建構術吧！
