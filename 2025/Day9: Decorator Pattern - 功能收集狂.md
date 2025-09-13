# Day 9: Decorator Pattern - 功能收集狂

## 老闆語錄 💬

> "按鈕很棒，但能不能加個動畫？加個音效？加個震動？加個香味？"

## 災難現場 🔥

週二下午，UI/UX 設計師小美正在向老闆展示新設計的登入按鈕。螢幕上顯示著一個簡潔優雅的藍色按鈕，字體清晰，邊角圓潤。

「這個按鈕很不錯！」老闆點頭稱讚，「但是...」

小美的心臟瞬間停了半拍。在職場中，「但是」這兩個字後面通常跟著災難。

「我覺得它缺少一點『生命力』！」老闆站起來，開始在空中比劃，「能不能讓它有呼吸的感覺？就是那種一大一小的動畫效果！」

工程師阿明弱弱地說：「加個呼吸動畫可以...」

「太好了！」老闆興奮得像個孩子，「然後點擊的時候能不能有音效？就像那種『叮咚』的聲音！」

「音效也可以做...」阿明繼續說道。

「還有還有！」老闆的眼神越來越亮，「現在手機都有震動功能對吧？點按鈕的時候能不能震動一下？增加觸覺回饋！」

此時產品經理阿強試圖理性分析：「那個...我們是網頁應用，沒有震動功能...」

「那就加上！」老闆揮揮手，「科技不是無所不能嗎？還有，我昨天看到一個廣告，說未來的螢幕可以散發香味，我們能不能也加上這個功能？」

全場陷入尷尬的沉默。

突然老闆拍了拍手：「我知道了！我們可以做一個『功能增強器』！基本按鈕是基本功能，然後用戶可以選擇要加哪些特效！就像遊戲裝備強化一樣！」

此時你恍然大悟，老闆並不是在胡鬧，而是在無意中展示 **Decorator Pattern** 的核心概念 - **在不改變物件結構的前提下，動態地為物件添加新功能**。

## 模式解析 🧠

Decorator Pattern（裝飾者模式）是結構型設計模式中的包裝大師，它的核心思想是：**通過將物件包裝在裝飾器物件中來動態地增加功能，而不需要修改原始物件的結構**。

在我們的職場災難中，老闆的功能疊加需求完美地展現了為什麼需要 Decorator Pattern：

1. **功能動態添加**：用戶可以選擇要哪些增強功能
2. **組合靈活性**：不同功能可以任意組合
3. **原始物件保護**：基礎按鈕不需要修改
4. **逐步增強**：可以一層一層地添加功能

Decorator Pattern 適用於以下情境：

- **功能可選組合**：用戶可以自由選擇需要的功能
- **避免子類爆炸**：不用為每種組合創建子類
- **運行時擴展**：需要在程式執行時動態添加功能
- **職責分離**：每個裝飾器專注於單一功能

Decorator Pattern 的優勢：

- **開放封閉原則**：對擴展開放，對修改封閉
- **靈活組合**：可以任意組合不同的裝飾器
- **單一職責**：每個裝飾器只負責一種功能
- **動態配置**：運行時決定要添加哪些功能

## 程式碼範例 💻

讓我們來實作一個簡化的「功能裝飾系統」，展示 Decorator Pattern 的核心概念：

```ts
// 基礎組件介面
interface Button {
  click(): string;
  getCost(): number;
}

// 基礎按鈕
class BasicButton implements Button {
  constructor(private text: string) {}

  click(): string {
    return `點擊: ${this.text}`;
  }

  getCost(): number {
    return 0;
  }
}

// 抽象裝飾器
abstract class ButtonDecorator implements Button {
  constructor(protected button: Button) {}

  click(): string {
    return this.button.click();
  }

  getCost(): number {
    return this.button.getCost();
  }
}

// 動畫裝飾器
class AnimationDecorator extends ButtonDecorator {
  click(): string {
    return this.button.click() + " + 動畫效果";
  }

  getCost(): number {
    return this.button.getCost() + 50;
  }
}

// 音效裝飾器
class SoundDecorator extends ButtonDecorator {
  click(): string {
    return this.button.click() + " + 音效";
  }

  getCost(): number {
    return this.button.getCost() + 30;
  }
}

// 震動裝飾器
class VibrationDecorator extends ButtonDecorator {
  click(): string {
    return this.button.click() + " + 震動";
  }

  getCost(): number {
    return this.button.getCost() + 40;
  }
}

// 使用範例 - 動態添加功能
let button: Button = new BasicButton("登入");
console.log(button.click()); // 點擊: 登入

button = new AnimationDecorator(button);
console.log(button.click()); // 點擊: 登入 + 動畫效果

button = new SoundDecorator(button);
console.log(button.click()); // 點擊: 登入 + 動畫效果 + 音效

button = new VibrationDecorator(button);
console.log(button.click()); // 點擊: 登入 + 動畫效果 + 音效 + 震動
console.log(`總成本: $${button.getCost()}`); // 總成本: $120
```

## 生存技巧 🛡️

1. **裝飾器設計原則**：

   - **介面一致性**：所有裝飾器都要實作相同介面
   - **單一職責**：每個裝飾器只負責一種功能
   - **組合順序**：考慮裝飾器的添加順序是否影響結果
   - **效能考量**：避免過多層次的裝飾器影響效能

2. **與老闆溝通策略**：

   - **成本透明化**：清楚展示每個功能的開發成本
   - **優先級排序**：引導老闆為功能設定優先級
   - **技術可行性**：解釋某些功能（如香味）的技術限制
   - **漸進式實作**：建議分階段實作不同功能

3. **技術實作要點**：

   - **基礎介面穩定**：確保基礎介面不會頻繁變更
   - **裝飾器順序**：有些功能組合順序會影響效果
   - **記憶體管理**：注意裝飾器鏈可能造成的記憶體問題
   - **除錯友善**：提供清楚的裝飾器識別機制

4. **產品策略建議**：
   - **套餐設計**：提供預設的功能組合套餐
   - **用戶自訂**：允許進階用戶自由組合功能
   - **A/B 測試**：測試不同功能組合的用戶接受度
   - **效能監控**：監控複雜裝飾器對系統效能的影響

## 明日預告 🔮

**Facade Pattern - 簡化大師**，探討老闆的簡化哲學：「我不管你們用了多少台伺服器，我只要看到結果！」

準備迎接老闆的魔法按鈕夢想和萬能儀表板的挑戰吧！
