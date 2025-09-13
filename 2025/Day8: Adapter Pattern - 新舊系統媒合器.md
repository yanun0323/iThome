# Day 8: Adapter Pattern - 新舊系統媒合器

## 老闆語錄 💬

> "原本網站不能動，但要加上區塊鏈功能！"

## 災難現場 🔥

週一早上的緊急會議，會議室裡瀰漫著一股不安的氣氛。IT 部經理小張一臉疲憊地站在投影機前，螢幕上顯示著密密麻麻的系統架構圖。

「各位，我要宣布一個壞消息...」小張清了清嗓子，「我們的核心業務系統是 10 年前用 Java 寫的，文件已經失傳，原開發團隊也都離職了...」

全場一片寂靜，連老闆都停止了喝咖啡的動作。

「更糟的是，」小張繼續說道，「這個系統還跟我們的財務系統、客戶管理系統、庫存系統緊密耦合。如果要重寫，至少需要兩年時間和一千萬預算...」

此時老闆突然站起來，眼神發亮：「等等！我昨天去區塊鏈大會，學到了一個革命性的概念！」

所有人的心都沈了下去。經驗告訴大家，老闆的「革命性概念」通常意味著更多的加班。

「我們不需要重寫系統！」老闆在白板上畫了一個奇怪的圖形，「我們要做一個『時空橋樑』！讓舊系統可以跟新技術對話！」

工程師阿明困惑地問：「時空橋樑？」

「對！就像手機轉接頭一樣！」老闆越說越興奮，「舊系統用舊介面，新功能用新介面，中間放一個轉換器！我們的區塊鏈錢包要能跟十年前的支付系統完美配合！」

此時你突然領悟到，老闆並沒有在胡說八道，而是在直覺地描述 **Adapter Pattern** 的精髓 - **讓不相容的介面能夠協同工作**。

老闆最後總結：「我們要成為『系統翻譯專家』！不管多古老的系統，都要能跟最新的技術無縫整合！」

## 模式解析 🧠

Adapter Pattern（適配器模式）是結構型設計模式中的外交官，它的核心思想是：**將一個類別的介面轉換成客戶端期望的另一個介面，讓原本不相容的類別能夠協同工作**。

在我們的職場災難中，老闆的系統整合需求完美地展現了為什麼需要 Adapter Pattern：

1. **遺留系統包袱**：舊系統功能正常但介面過時
2. **技術棧差異**：新舊技術使用不同的通訊協定
3. **介面不匹配**：資料格式和方法簽名不一致
4. **避免重寫成本**：保護既有投資，漸進式升級

Adapter Pattern 適用於以下情境：

- **系統整合**：需要整合不同廠商或不同時期的系統
- **API 版本升級**：新版本 API 需要相容舊版本
- **第三方函式庫整合**：包裝外部函式庫的複雜介面
- **資料格式轉換**：不同系統間的資料交換

Adapter Pattern 的優勢：

- **保護既有投資**：避免大規模重寫的風險和成本
- **介面統一**：為客戶端提供一致的操作介面
- **職責分離**：適配器專注於轉換，業務邏輯保持純淨
- **漸進式升級**：可以逐步替換或升級系統組件

## 程式碼範例 💻

讓我們來實作一個簡化的「新舊系統橋樑」，展示 Adapter Pattern 的核心概念：

```ts
// 舊系統 - 10年前的支付系統
class LegacyPaymentSystem {
  processPayment(accountNumber: string, amount: number): string {
    console.log(`[舊系統] 處理支付: ${accountNumber} - $${amount}`);
    return `OLD_TXN_${Date.now()}`;
  }
}

// 新系統期望的介面
interface ModernPaymentInterface {
  pay(userId: string, amount: number): boolean;
}

// 新技術 - 區塊鏈支付
class BlockchainWallet {
  createTransaction(address: string, amount: number): string {
    console.log(`[區塊鏈] 支付: ${address} - ${amount} ETH`);
    return `0x${Math.random().toString(16).substr(2, 8)}`;
  }
}

// Adapter Pattern 核心 - 適配器
class PaymentAdapter implements ModernPaymentInterface {
  constructor(
    private legacySystem: LegacyPaymentSystem,
    private blockchain: BlockchainWallet
  ) {}

  pay(userId: string, amount: number): boolean {
    // 轉換格式並呼叫舊系統
    const accountNumber = `ACC_${userId}`;
    const txId = this.legacySystem.processPayment(accountNumber, amount);

    // 同時支援區塊鏈支付
    this.blockchain.createTransaction(`0x${userId}`, amount * 0.001);

    return txId.length > 0;
  }
}

// 使用範例
const legacySystem = new LegacyPaymentSystem();
const blockchain = new BlockchainWallet();
const adapter = new PaymentAdapter(legacySystem, blockchain);

// 現代化的使用方式
adapter.pay("user123", 1000);
// 輸出：
// [舊系統] 處理支付: ACC_user123 - $1000
// [區塊鏈] 支付: 0xuser123 - 1 ETH
```

## 生存技巧 🛡️

1. **適配器設計原則**：

   - **單一職責**：適配器只負責介面轉換，不處理業務邏輯
   - **透明封裝**：隱藏舊系統的複雜性，提供簡潔介面
   - **錯誤處理**：妥善處理新舊系統間的例外狀況
   - **效能考量**：避免過度的資料轉換影響系統效能

2. **與老闆溝通策略**：

   - **風險說明**：解釋直接修改舊系統的風險
   - **成本比較**：展示適配器相對於重寫的成本優勢
   - **漸進計畫**：提出分階段整合的實施計畫
   - **備用方案**：準備舊系統故障時的應急措施

3. **技術實作要點**：

   - **介面設計**：新介面要考慮未來擴展性
   - **資料驗證**：確保轉換後的資料完整性
   - **監控機制**：建立適配器的運行監控
   - **文檔維護**：詳細記錄轉換邏輯和資料映射

4. **團隊協作建議**：
   - **領域專家**：找到熟悉舊系統的同事協助
   - **測試策略**：建立完整的整合測試
   - **部署計畫**：規劃零停機時間的部署方案
   - **回滾準備**：準備快速回滾到舊系統的機制

## 明日預告 🔮

**Decorator Pattern - 功能收集狂**，探討老闆的新挑戰：「按鈕很棒，但能不能加個動畫？加個音效？加個震動？加個香味？」

準備迎接老闆的功能蒐集癖和無限包裝的藝術吧！
