# Day 4: Builder Pattern - 需求疊疊樂

## 老闆語錄 💬

> "我要免費的，但要比付費版更好用！"

## 災難現場 🔥

週四早上 10 點，你正在享受著昨天 Singleton Pattern 帶來的短暫平靜，突然老闆拿著一疊競品分析衝進辦公室。

「我研究了一下市面上的產品，」老闆把資料攤在桌上，「我發現我們的產品太簡單了！」

你內心一緊，經驗告訴你這是暴風雨前的寧靜。

「你看這個 A 產品有 AI 功能，這個 B 產品有區塊鏈，這個 C 產品有 VR 體驗！」老闆越說越興奮，「我們要把這些功能都加進去！」

設計師小美弱弱地問：「那我們的核心功能是什麼？」

「都是核心功能！」老闆理直氣壯地說，「而且我們要做得比他們都好！A 產品的 AI 要 100 倍聰明，B 產品的區塊鏈要 1000 倍安全，C 產品的 VR 要讓人分不清現實！」

工程師阿明試圖理性分析：「但這樣預算會...」

「不用擔心預算！」老闆揮揮手，「我們要做一個基礎版是免費的，但功能要比付費版更多的產品！」

你看著老闆，突然意識到他不是在開玩笑，而是在無意中教導你 **Builder Pattern** 的精髓：**一步一步構建複雜物件，每個步驟都可以選擇性添加或配置**。

## 模式解析 🧠

Builder Pattern（建造者模式）是創建型設計模式中的積木大師，它的核心思想是：**將複雜物件的構建過程分解成多個簡單步驟，讓客戶端可以靈活地選擇和組合這些步驟**。

在我們的職場災難中，老闆的貪心特性完美地展現了為什麼需要 Builder Pattern：

1. **複雜物件構建**：產品有很多可選功能
2. **步驟可選性**：用戶可以選擇要哪些功能
3. **配置靈活性**：每個功能都有不同的配置選項
4. **構建過程隔離**：構建邏輯與最終產品分離

Builder Pattern 適用於以下情境：

- **複雜物件創建**：物件有很多可選參數
- **配置多樣性**：需要支援多種配置組合
- **步驟式構建**：創建過程需要按特定順序進行
- **不可變物件**：創建後物件狀態不可改變

Builder Pattern 的優勢：

- **程式碼可讀性**：鏈式調用讓構建過程清晰
- **參數驗證**：可以在構建過程中驗證參數
- **不可變性**：避免物件創建後被意外修改
- **擴展性**：新增功能不影響現有程式碼

## 程式碼範例 💻

讓我們來實作一個「夢幻產品建造器」，展示 Builder Pattern 的威力：

```ts
// Product 產品類別 - 最終構建的複雜物件
class DreamProduct {
  private features: string[] = [];
  private price: number = 0;
  private version: string = "基礎版";

  constructor(features: string[], price: number, version: string) {
    this.features = [...features];
    this.price = price;
    this.version = version;
  }

  public getDescription(): string {
    return `${this.version} - $${this.price}\n功能：${this.features.join(
      ", "
    )}`;
  }
}

// ProductBuilder 產品建造器 - Builder Pattern 核心
class ProductBuilder {
  private features: string[] = [];
  private price: number = 0;
  private version: string = "基礎版";

  // 添加 AI 功能
  public addAI(): ProductBuilder {
    this.features.push("超智能 AI 助手");
    this.price += 1000;
    return this;
  }

  // 添加區塊鏈功能
  public addBlockchain(): ProductBuilder {
    this.features.push("量子級區塊鏈安全");
    this.price += 2000;
    return this;
  }

  // 添加 VR 功能
  public addVR(): ProductBuilder {
    this.features.push("沉浸式 VR 體驗");
    this.price += 1500;
    return this;
  }

  // 添加雲端同步
  public addCloudSync(): ProductBuilder {
    this.features.push("雲端同步");
    this.price += 500;
    return this;
  }

  // 設定版本
  public setVersion(version: string): ProductBuilder {
    this.version = version;
    return this;
  }

  // 老闆特殊要求：免費但更好
  public makeBetterAndFree(): ProductBuilder {
    this.price = 0;
    this.version = "免費增強版";
    this.features.push("比付費版更好的體驗");
    return this;
  }

  // 構建最終產品
  public build(): DreamProduct {
    if (this.features.length === 0) {
      this.features.push("基本功能");
    }

    return new DreamProduct(this.features, this.price, this.version);
  }
}

// 使用範例
function demonstrateBuilder(): void {
  console.log("Builder Pattern 核心概念展示");
  console.log("===========================");

  // 基礎產品
  const basicProduct = new ProductBuilder().build();
  console.log("基礎產品：");
  console.log(basicProduct.getDescription());

  // 高階產品（鏈式調用）
  const premiumProduct = new ProductBuilder()
    .addAI()
    .addBlockchain()
    .addVR()
    .setVersion("豪華版")
    .build();
  console.log("\n豪華版產品：");
  console.log(premiumProduct.getDescription());

  // 老闆的夢幻需求
  const bossProduct = new ProductBuilder()
    .addAI()
    .addBlockchain()
    .addVR()
    .addCloudSync()
    .makeBetterAndFree()
    .build();
  console.log("\n老闆夢幻產品：");
  console.log(bossProduct.getDescription());
}

demonstrateBuilder();
```

## 生存技巧 🛡️

1. **合理設計步驟**：將複雜物件的創建分解成邏輯清晰的步驟
2. **支援鏈式調用**：讓 builder 方法返回 this，提高程式碼可讀性
3. **驗證機制**：在 build() 方法中驗證必要參數
4. **不可變性**：確保 build() 後的物件狀態不可改變
5. **現實期望管理**：溫和地向老闆解釋「免費且更好」的技術挑戰

## 明日預告 🔮

**Prototype Pattern - 抄襲有理**，探討老闆的經典台詞：「我們要開發跟 Google 一樣的搜尋引擎，但要比它快！」

準備迎接老闆的模仿天賦和原型複製的藝術吧！
