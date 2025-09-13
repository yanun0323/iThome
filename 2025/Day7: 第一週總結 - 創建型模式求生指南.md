# Day 7: 第一週總結 - 創建型模式求生指南

## 老闆語錄 💬

> "這一週我們學到了什麼？很好！下週我們要做更大的！"

## 災難現場 🔥

週日晚上 11 點，你正準備享受週末的最後時光，手機突然響起。螢幕上顯示著老闆的名字，你的心跳瞬間加速。

「喂？怎麼了？」你戰戰兢兢地接起電話。

「我剛剛在家看 Netflix，突然想到這週的進展！」老闆的聲音異常興奮，「我們從需求工廠到產品線工廠，已經建立了一個完整的創造帝國！」

你揉揉眼睛，試圖讓自己清醒一點：「呃...是的，我們學了很多創建型模式...」

「對！就是這個！」老闆在電話那頭踱步的聲音清晰可聞，「我在想，既然我們已經掌握了『如何造東西』的所有招式，下一步就是要學會『如何組合東西』！」

你開始意識到，這通電話可能會改變你整個下週的計畫。

「我有一個偉大的構想！」老闆繼續說道，「我們要建立一個『系統整合超級工廠』！不只是造產品，還要讓所有東西完美結合！就像...就像變形金剛一樣！」

此時你突然明白，老闆不是在破壞你的週末，而是在預告下週即將到來的**結構型模式**挑戰。創建型模式教會我們如何造東西，結構型模式則要教我們如何組合東西。

「明天早上 9 點開會，我們要規劃下週的『結構型革命』！」老闆掛斷電話前補充道。

你看著手機，深吸一口氣，心想：「至少我現在已經有了創建型模式的完整武器庫...」

## 模式解析 🧠

經過一週的血淚洗禮，我們已經完整掌握了創建型設計模式的所有核心概念。讓我們來回顧這場「創建大師養成記」：

### 創建型模式全家福

**Factory Pattern - 需求製造機**

- **核心思想**：封裝物件創建邏輯，隱藏複雜的實例化過程
- **老闆語錄**：「你先幫我開發個功能，但我現在還不知道要什麼」
- **適用情境**：需求經常變更，需要根據條件創建不同類型的物件
- **生存技巧**：建立統一介面，讓老闆的善變不再是噩夢

**Singleton Pattern - 獨裁者養成記**

- **核心思想**：確保系統中只有一個實例，提供全局訪問點
- **老闆語錄**：「公司只能有一個我，所有決定都要經過我」
- **適用情境**：需要控制資源訪問、保證狀態一致性
- **生存技巧**：明智使用，避免過度依賴全局狀態

**Builder Pattern - 需求疊疊樂**

- **核心思想**：分步驟構建複雜物件，提供靈活的配置選項
- **老闆語錄**：「我要免費的，但要比付費版更好用」
- **適用情境**：物件創建過程複雜，需要多種配置組合
- **生存技巧**：鏈式調用讓程式碼更優雅，驗證機制保證品質

**Prototype Pattern - 抄襲有理**

- **核心思想**：通過複製現有物件創建新物件，避免昂貴的重新創建
- **老闆語錄**：「我們要開發跟 Google 一樣的搜尋引擎，但要比它快」
- **適用情境**：物件創建成本高，需要保持現有配置
- **生存技巧**：深度克隆要仔細，合法借鑑要謹慎

**Abstract Factory Pattern - 產品線狂想曲**

- **核心思想**：創建一系列相關物件，確保產品族群的一致性
- **老闆語錄**：「B2B、B2C、C2C、我們還要做 A2Z」
- **適用情境**：需要支援多個產品族群，保證內部組件相容
- **生存技巧**：族群規劃要清晰，擴展機制要預留

### 創建型模式使用指南

**選擇決策樹**：

1. 需要控制實例數量？ → 考慮 **Singleton**
2. 創建邏輯複雜多變？ → 考慮 **Factory**
3. 需要分步驟構建？ → 考慮 **Builder**
4. 創建成本昂貴？ → 考慮 **Prototype**
5. 需要產品族群管理？ → 考慮 **Abstract Factory**

**常見組合應用**：

- **Factory + Builder**：工廠負責決定類型，Builder 負責配置
- **Prototype + Factory**：工廠管理原型，按需複製
- **Singleton + Abstract Factory**：單例工廠管理器

## 程式碼範例 💻

讓我們來實作一個「創建型模式整合系統」，展示所有模式的協同工作：

```ts
// 綜合範例：老闆夢想實現系統
// 整合所有創建型模式的終極展示

// 1. Singleton - 系統配置管理器
class SystemConfig {
  private static instance: SystemConfig | null = null;
  private settings: Map<string, any> = new Map();

  private constructor() {
    // 預設配置
    this.settings.set("theme", "professional");
    this.settings.set("language", "zh-TW");
    this.settings.set("debug", false);
  }

  public static getInstance(): SystemConfig {
    if (!SystemConfig.instance) {
      SystemConfig.instance = new SystemConfig();
    }
    return SystemConfig.instance;
  }

  public set(key: string, value: any): void {
    this.settings.set(key, value);
  }

  public get(key: string): any {
    return this.settings.get(key);
  }
}

// 2. Prototype - 可複製的功能模組
abstract class FeatureModule {
  protected name: string = "";
  protected config: Map<string, any> = new Map();

  abstract clone(): FeatureModule;

  public configure(key: string, value: any): void {
    this.config.set(key, value);
  }

  public getName(): string {
    return this.name;
  }
}

class SearchModule extends FeatureModule {
  constructor() {
    super();
    this.name = "搜尋模組";
    this.config.set("algorithm", "basic");
    this.config.set("indexSize", 1000);
  }

  public clone(): SearchModule {
    const cloned = new SearchModule();
    this.config.forEach((value, key) => {
      cloned.configure(key, value);
    });
    return cloned;
  }
}

class SocialModule extends FeatureModule {
  constructor() {
    super();
    this.name = "社交模組";
    this.config.set("features", ["chat", "feed"]);
    this.config.set("maxFriends", 5000);
  }

  public clone(): SocialModule {
    const cloned = new SocialModule();
    this.config.forEach((value, key) => {
      cloned.configure(key, value);
    });
    return cloned;
  }
}

// 3. Builder - 產品建構器
class ProductBuilder {
  private name: string = "";
  private modules: FeatureModule[] = [];
  private targetMarket: string = "";

  public setName(name: string): ProductBuilder {
    this.name = name;
    return this;
  }

  public addModule(module: FeatureModule): ProductBuilder {
    this.modules.push(module.clone());
    return this;
  }

  public setTargetMarket(market: string): ProductBuilder {
    this.targetMarket = market;
    return this;
  }

  public build(): Product {
    return new Product(this.name, this.modules, this.targetMarket);
  }
}

// 產品類別
class Product {
  constructor(
    private name: string,
    private modules: FeatureModule[],
    private targetMarket: string
  ) {}

  public getDescription(): string {
    const moduleNames = this.modules.map((m) => m.getName()).join(", ");
    return `${this.name} (${this.targetMarket})\n功能模組：${moduleNames}`;
  }
}

// 4. Factory - 市場特化工廠
interface MarketFactory {
  createProduct(name: string): Product;
}

class B2BFactory implements MarketFactory {
  createProduct(name: string): Product {
    const searchModule = new SearchModule();
    searchModule.configure("algorithm", "enterprise");
    searchModule.configure("indexSize", 100000);

    return new ProductBuilder()
      .setName(name)
      .setTargetMarket("B2B")
      .addModule(searchModule)
      .build();
  }
}

class B2CFactory implements MarketFactory {
  createProduct(name: string): Product {
    const searchModule = new SearchModule();
    searchModule.configure("algorithm", "user-friendly");

    const socialModule = new SocialModule();
    socialModule.configure("features", ["chat", "feed", "share"]);

    return new ProductBuilder()
      .setName(name)
      .setTargetMarket("B2C")
      .addModule(searchModule)
      .addModule(socialModule)
      .build();
  }
}

// 5. Abstract Factory - 產品線管理器
class ProductLineManager {
  private factories: Map<string, MarketFactory> = new Map();

  constructor() {
    this.factories.set("B2B", new B2BFactory());
    this.factories.set("B2C", new B2CFactory());
  }

  public createProduct(market: string, productName: string): Product | null {
    const factory = this.factories.get(market);
    return factory ? factory.createProduct(productName) : null;
  }
}

// 使用範例 - 創建型模式協奏曲
function demonstrateCreationalPatterns(): void {
  console.log("創建型模式整合展示");
  console.log("==================");

  // 1. Singleton - 獲取系統配置
  const config = SystemConfig.getInstance();
  console.log(`系統主題：${config.get("theme")}`);

  // 2. Factory + Abstract Factory - 創建產品
  const manager = new ProductLineManager();

  const b2bProduct = manager.createProduct("B2B", "企業搜尋平台");
  const b2cProduct = manager.createProduct("B2C", "社交搜尋應用");

  console.log("\n創建的產品：");
  console.log(b2bProduct?.getDescription());
  console.log(b2cProduct?.getDescription());

  // 3. Builder - 自定義產品
  const customProduct = new ProductBuilder()
    .setName("老闆夢想產品")
    .setTargetMarket("A2Z")
    .addModule(new SearchModule())
    .addModule(new SocialModule())
    .build();

  console.log("\n老闆的夢想產品：");
  console.log(customProduct.getDescription());

  console.log("\n✅ 創建型模式整合成功！");
}

demonstrateCreationalPatterns();
```

## 生存技巧 🛡️

### 第一週生存總結

1. **模式選擇策略**：

   - 分析需求本質：是創建什麼問題？
   - 評估複雜度：簡單問題不要過度設計
   - 考慮擴展性：未來可能的變化方向

2. **與老闆溝通技巧**：

   - **翻譯需求**：將老闆語言轉換為技術語言
   - **展示價值**：用實際範例證明模式的好處
   - **管理期望**：合理解釋技術限制

3. **程式碼品質保證**：

   - **命名清晰**：讓程式碼自說明
   - **介面簡潔**：隱藏複雜度，暴露必要功能
   - **文檔完整**：為未來的自己留下線索

4. **團隊協作要點**：
   - **模式共識**：確保團隊理解所選模式
   - **程式碼審查**：檢查模式使用是否得當
   - **重構準備**：隨時準備優化設計

## 明日預告 🔮

下週我們將進入**結構型模式**的世界！準備迎接老闆的新挑戰：

**Day 8: Adapter Pattern - 新舊系統媒合器**
「原本網站不能動，但要加上區塊鏈功能」

創建型模式教會我們如何造東西，結構型模式將教會我們如何組合東西！準備好接受更大的挑戰了嗎？

記住：**在老闆的瘋狂想法中，隱藏著軟體架構的最高智慧！** 🚀
