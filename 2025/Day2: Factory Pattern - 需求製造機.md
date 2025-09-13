# Day 2: Factory Pattern - 需求製造機

## 老闆語錄 💬

> "你先幫我開發個功能，但我現在還不知道要什麼。"

## 災難現場 🔥

週二早上 9 點，你正專心寫著昨天老闆要求的「簡單搜尋功能」，突然老闆又出現了。

「昨天那個搜尋啊，我想了一下，可能需要改一下。」老闆一邊喝咖啡一邊說道。

你內心開始有不祥的預感，但還是禮貌地問：「要改什麼呢？」

「嗯...我還沒想好，但可能是文字搜尋，也可能是圖片搜尋，或者語音搜尋，甚至可能是味道搜尋！對！味道搜尋很有創意！」老闆越說越興奮。

你試圖保持冷靜：「那...我應該先做哪一種？」

「都要！但我現在還不確定用戶會想要哪一種，所以你先寫一個框架，到時候我告訴你要什麼，你就給我什麼。」

此時你終於明白，老闆並不是在刁難你，他只是在無意識地教導你 **Factory Pattern** 的精髓：**在不指定具體類別的情況下創建物件**。

老闆繼續說：「對了，下個月我們可能要支援外星人的搜尋需求，你也要考慮進去。記住，要有彈性！」

你看著螢幕上的程式碼，深深吸了一口氣。是時候建立一個「需求製造機」了。

## 模式解析 🧠

Factory Pattern（工廠模式）是創建型設計模式的經典代表，它的核心思想是：**將物件的創建過程封裝起來，讓客戶端不需要知道具體要創建哪種物件**。

在我們的職場災難中，老闆的善變特性完美地展現了為什麼需要 Factory Pattern：

1. **需求不確定性**：老闆現在不知道要什麼，但未來會知道
2. **類型多樣性**：可能是文字、圖片、語音，甚至是味道搜尋
3. **擴展性需求**：未來還要支援外星人搜尋（！）

Factory Pattern 解決了這些問題：

- **封裝創建邏輯**：隱藏複雜的物件創建過程
- **降低耦合度**：客戶端不需要知道具體的實現類別
- **提高擴展性**：新增類型時不需要修改現有程式碼
- **統一介面**：所有產品都遵循相同的介面

這就像是一個神奇的需求製造機：你丟入一個需求類型，它就吐出對應的實現物件。老闆要什麼，工廠就造什麼！

## 程式碼範例 💻

讓我們來實作一個「老闆需求製造機」，展示 Factory Pattern 的威力：

```ts
// SearchEngine 介面定義所有搜尋引擎的共同契約
interface SearchEngine {
  search(query: string): string[];
  getType(): string;
}

// TextSearchEngine 文字搜尋引擎實作
class TextSearchEngine implements SearchEngine {
  search(query: string): string[] {
    return [`找到文字結果: '${query}'`, `相關文章: '${query}'的完整指南`];
  }

  getType(): string {
    return "文字搜尋";
  }
}

// ImageSearchEngine 圖片搜尋引擎實作
class ImageSearchEngine implements SearchEngine {
  search(query: string): string[] {
    return [`找到圖片: ${query}.jpg`, `類似圖片: ${query}_similar.png`];
  }

  getType(): string {
    return "圖片搜尋";
  }
}

// VoiceSearchEngine 語音搜尋引擎實作
class VoiceSearchEngine implements SearchEngine {
  search(query: string): string[] {
    return [`語音識別結果: '${query}'`, `發音指導: 如何正確念'${query}'`];
  }

  getType(): string {
    return "語音搜尋";
  }
}

// SearchEngineType 搜尋引擎類型枚舉
enum SearchEngineType {
  TEXT = "text",
  IMAGE = "image",
  VOICE = "voice",
}

// createSearchEngine 工廠函數 - 根據類型建立搜尋引擎
function createSearchEngine(engineType: SearchEngineType): SearchEngine {
  switch (engineType) {
    case SearchEngineType.TEXT:
      return new TextSearchEngine();
    case SearchEngineType.IMAGE:
      return new ImageSearchEngine();
    case SearchEngineType.VOICE:
      return new VoiceSearchEngine();
    default:
      throw new Error(`不支援的搜尋引擎類型: ${engineType}`);
  }
}

// main 主函數 - 展示 Factory Pattern 的使用
function main(): void {
  console.log("Factory Pattern 範例");
  console.log("===================");

  // 不同的搜尋需求
  const searchTypes: SearchEngineType[] = [
    SearchEngineType.TEXT,
    SearchEngineType.IMAGE,
    SearchEngineType.VOICE,
  ];

  for (const searchType of searchTypes) {
    try {
      // 使用工廠建立對應的搜尋引擎
      const engine = createSearchEngine(searchType);

      // 執行搜尋
      console.log(`\n使用 ${engine.getType()}:`);
      const results = engine.search("Go 語言");
      results.forEach((result, index) => {
        console.log(`  ${index + 1}. ${result}`);
      });
    } catch (error) {
      console.error(`建立失敗: ${error}`);
    }
  }
}
```

## 生存技巧 🛡️

1. **建立工廠介面**：定義統一的創建方法，讓老闆的需求變更不會影響主要邏輯
2. **使用註冊機制**：新增功能時不需要修改工廠的核心程式碼
3. **準備預設選項**：當老闆需求不明確時，提供合理的預設實作
4. **複雜度警示**：用數據告訴老闆某些「簡單」需求其實很複雜
5. **展示擴展性**：向老闆證明你的架構可以應對未來的瘋狂想法

## 明日預告 🔮

**Singleton Pattern - 獨裁者養成記**，探討老闆的經典台詞：「公司只能有一個我，所有決定都要經過我！」

準備迎接更多的控制慾分析和程式碼實作吧！
