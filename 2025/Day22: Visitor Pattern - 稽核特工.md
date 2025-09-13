# Day 22: Visitor Pattern - 稽核特工

## 老闆語錄 💬

> "我要對每個部門做不同的檢查，但不想改變部門結構！銷售部查業績，技術部查代碼，財務部查帳本！"

## 災難現場 🔥

週一早上的全體會議，老闆手裡拿著一疊厚厚的稽核計畫書，臉色嚴肅地站在投影螢幕前。

「各位！」老闆清了清嗓子，「上季度我們虧了不少錢，我決定要做『全面品質稽核』！」

人事經理小張緊張地問：「什麼意思？」

老闆開始在白板上畫組織圖：「每個部門都要接受檢查！但是...」他停頓了一下，「每個部門的檢查內容完全不同！」

「銷售部！」他指著圖上的一個方塊，「我要檢查客戶滿意度、成交率、回購率！」

「技術部！」又指向另一個方塊，「我要檢查代碼品質、系統穩定性、創新程度！」

「財務部！」繼續指著第三個方塊，「我要檢查資金流向、預算執行、合規性！」

財務主管老陳困惑地問：「那我們要準備不同的檢查流程嗎？」

「不不不！」老闆搖頭，「部門結構不能改！我不想因為稽核而重新組織架構！」

系統分析師小李提出疑問：「但是每個部門的檢查邏輯都不一樣啊...」

「這就是重點！」老闆眼神發亮，「我要派『專業稽核員』！每個稽核員都是特定領域的專家！業績稽核員只懂業績檢查，技術稽核員只懂技術檢查，財務稽核員只懂財務檢查！」

他繼續興奮地解釋：「稽核員到各部門『拜訪』，根據部門特性執行不同的檢查程序！部門本身不用改變，但檢查的方式完全客製化！」

產品經理阿美試圖理解：「所以是...檢查邏輯和部門結構分離？」

「對！」老闆總結，「就像『外部專家顧問』！他們帶著專業知識到各部門，針對不同部門特色提供專業建議！部門還是原來的部門，但能得到專業的檢查服務！」

你突然恍然大悟，老闆描述的就是 **Visitor Pattern** - **在不改變元素類別的前提下，定義作用於這些元素的新操作**！

## 模式解析 🧠

Visitor Pattern（訪問者模式）是行為型設計模式中的外交大使，它的核心思想是：**在不修改已有類別的情況下，定義新的操作，通過雙重分派機制實現操作與資料結構的分離**。

在我們的稽核災難中，老闆的專業檢查需求完美地展現了 Visitor Pattern 的本質：

1. **結構穩定**：部門組織不需要修改
2. **操作多樣**：不同類型的稽核檢查
3. **專業分工**：每個稽核員專精特定檢查
4. **擴展容易**：添加新檢查不影響原結構

Visitor Pattern 的核心組件：

- **Visitor**：訪問者介面，定義針對不同元素的訪問方法
- **ConcreteVisitor**：具體訪問者，實作特定的操作邏輯
- **Element**：元素介面，定義接受訪問者的方法
- **ConcreteElement**：具體元素，實作接受訪問的邏輯
- **ObjectStructure**：物件結構，管理元素集合

適用情境：

- **穩定結構，變化操作**：資料結構穩定，但需要頻繁添加新操作
- **複雜層次結構**：樹狀結構的多種遍歷和處理方式
- **編譯器設計**：AST 的多種分析和轉換操作
- **報表系統**：同一資料的多種輸出格式

## 程式碼範例 💻

讓我們實作一個「企業稽核系統」，展示 Visitor Pattern 的核心概念：

```ts
// 訪問者介面
interface AuditVisitor {
  visitSales(dept: SalesDept): string;
  visitTech(dept: TechDept): string;
}

// 部門介面
interface Department {
  accept(visitor: AuditVisitor): string;
}

// 具體部門
class SalesDept implements Department {
  constructor(private revenue: number) {}

  accept(visitor: AuditVisitor): string {
    return visitor.visitSales(this);
  }

  getRevenue(): number {
    return this.revenue;
  }
}

class TechDept implements Department {
  constructor(private codeQuality: number) {}

  accept(visitor: AuditVisitor): string {
    return visitor.visitTech(this);
  }

  getCodeQuality(): number {
    return this.codeQuality;
  }
}

// 具體訪問者：績效稽核
class PerformanceAuditor implements AuditVisitor {
  visitSales(dept: SalesDept): string {
    return `📊 銷售業績: ${dept.getRevenue()}`;
  }

  visitTech(dept: TechDept): string {
    return `⚡ 代碼品質: ${dept.getCodeQuality()}分`;
  }
}

// 具體訪問者：風險稽核
class RiskAuditor implements AuditVisitor {
  visitSales(dept: SalesDept): string {
    const risk = dept.getRevenue() < 100000 ? "高風險" : "低風險";
    return `⚠️ 營收風險: ${risk}`;
  }

  visitTech(dept: TechDept): string {
    const risk = dept.getCodeQuality() < 80 ? "高風險" : "低風險";
    return `🔧 技術風險: ${risk}`;
  }
}

// 使用範例
const departments = [
  new SalesDept(150000),
  new TechDept(85)
];

const performanceAuditor = new PerformanceAuditor();
const riskAuditor = new RiskAuditor();

console.log("=== 績效稽核 ===");
departments.forEach(dept => console.log(dept.accept(performanceAuditor)));

console.log("=== 風險稽核 ===");
departments.forEach(dept => console.log(dept.accept(riskAuditor)));
```

## 生存技巧 🛡️

1. **Visitor 設計原則**：

   - **雙重分派**：利用方法重載實現精確匹配
   - **開放封閉**：添加新操作無需修改現有結構
   - **單一職責**：每個訪問者專注一種操作
   - **穩定前提**：元素結構需要相對穩定

2. **與老闆溝通策略**：

   - **專業分工**：強調專家系統的價值
   - **結構保護**：說明如何不破壞現有組織
   - **擴展靈活**：展示如何輕易添加新檢查
   - **結果可比**：不同訪問者提供不同視角

3. **技術實作要點**：

   - **介面設計**：訪問者介面要包含所有元素類型
   - **型別安全**：利用編譯器檢查確保完整性
   - **效能考量**：避免過深的訪問者鏈
   - **錯誤處理**：處理訪問過程中的例外情況

4. **架構決策建議**：
   - **適用評估**：確認元素結構真的穩定
   - **複雜度權衡**：避免為簡單操作引入過度複雜性
   - **維護成本**：考慮新增元素類型的維護負擔
   - **替代方案**：評估是否可用其他模式替代

## 明日預告 🔮

明天我們將探討 **Mediator Pattern - 吵架調解員**，學習如何應對老闆的和事佬角色：「你們不要直接吵架，有事都來找我調解！」

準備迎接溝通協調的挑戰！ 🤝
