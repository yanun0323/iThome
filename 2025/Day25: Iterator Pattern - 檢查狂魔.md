# Day 25: Iterator Pattern - 檢查狂魔

## 老闆語錄 💬

> "我要一個一個檢查，不能漏掉任何細節！先檢查所有員工的工作進度，再檢查每個專案的執行狀況，然後檢查每筆預算的使用情況！"

## 災難現場 🔥

週四下午的季末檢討會議，老闆拿著厚厚一疊資料坐在會議桌首位，眼神專注得像要用X光掃描每個人。

「好！」老闆拍了拍桌上的文件，「這個季度結束了，我要『全面檢查』！」

HR 主管小陳緊張地問：「檢查什麼？」

老闆開始攤開各種表格：「員工績效表、專案進度表、預算執行表、客戶滿意度表...我要一項一項、一筆一筆、一個一個仔細檢查！」

財務主管老趙看著山一樣的資料嘆氣：「這...要檢查到什麼時候？」

「不急！」老闆摸了摸下巴，「我有『系統化檢查法』！先從員工開始，按照部門順序，每個人的每項指標都要看；然後檢查專案，按照優先級順序，每個階段每個任務都要審；最後檢查預算，按照類別順序，每筆支出每個項目都要核對！」

系統分析師小莉疑惑地問：「那資料格式都不一樣，要怎麼統一檢查？」

「這就是重點！」老闆興奮地站起來，「我要設計一個『智能檢查機』！不管什麼類型的資料，都能用同樣的方式逐一檢查！」

他開始在白板上畫圖：「就像掃描器一樣！從第一筆資料開始，一筆一筆往下掃，每筆都用相同的檢查流程，但檢查的內容可以不同！」

產品經理阿凱困惑地問：「那檢查機要怎麼知道下一筆資料在哪裡？」

「自動偵測！」老闆畫了個箭頭，「檢查機會知道：現在檢查哪一筆、下一筆是什麼、還有沒有資料要檢查、什麼時候結束！而且不管是員工清單、專案清單、還是預算清單，都用同樣的方式檢查！」

前端工程師小美試圖理解：「所以是...統一的瀏覽方式？」

「對！」老闆總結，「就像『萬能遙控器』！不管是電視、冷氣、還是音響，上一頁、下一頁、播放、停止的按鈕都一樣！但操作的內容不同！」

你突然明白了，老闆在描述 **Iterator Pattern** - **提供一種方法順序存取一個聚合物件中各個元素，而又不暴露該物件的內部表示**！

## 模式解析 🧠

Iterator Pattern（迭代器模式）是行為型設計模式中的巡邏兵，它的核心思想是：**提供一種方法來順序存取聚合物件中的各個元素，而不需要暴露該物件的內部結構**。

在我們的檢查狂魔災難中，老闆的系統化檢查需求完美地展現了 Iterator Pattern 的本質：

1. **統一存取**：不同類型資料用相同方式遍歷
2. **順序控制**：明確的前進、後退、開始、結束
3. **封裝保護**：不暴露內部資料結構
4. **狀態維護**：記住當前檢查到哪裡

Iterator Pattern 的核心組件：

- **Iterator**：迭代器介面，定義存取和遍歷的方法
- **ConcreteIterator**：具體迭代器，實作遍歷邏輯
- **Aggregate**：聚合介面，定義創建迭代器的方法
- **ConcreteAggregate**：具體聚合，實作迭代器創建

適用情境：

- **集合遍歷**：陣列、清單、樹狀結構的統一遍歷
- **資料處理**：批次處理、逐筆檢查、流式處理
- **多種遍歷**：同一資料的不同順序遍歷
- **封裝保護**：隱藏複雜的內部資料結構

## 程式碼範例 💻

讓我們實作一個「企業檢查系統」，展示 Iterator Pattern 的核心概念：

```ts
// 迭代器介面
interface Iterator<T> {
  hasNext(): boolean;
  next(): T | null;
}

// 聚合介面
interface Aggregate<T> {
  createIterator(): Iterator<T>;
}

// 檢查項目
class CheckItem {
  constructor(
    private name: string,
    private status: string
  ) {}

  getName(): string {
    return this.name;
  }

  getStatus(): string {
    return this.status;
  }

  getDetails(): string {
    return `${this.name}: ${this.status}`;
  }
}

// 具體迭代器
class CheckListIterator implements Iterator<CheckItem> {
  private position: number = 0;

  constructor(private items: CheckItem[]) {}

  hasNext(): boolean {
    return this.position < this.items.length;
  }

  next(): CheckItem | null {
    if (this.hasNext()) {
      return this.items[this.position++];
    }
    return null;
  }
}

// 具體聚合：檢查清單
class CheckList implements Aggregate<CheckItem> {
  private items: CheckItem[] = [];

  addItem(item: CheckItem): void {
    this.items.push(item);
  }

  createIterator(): Iterator<CheckItem> {
    return new CheckListIterator(this.items);
  }

  // 根據狀態篩選的迭代器
  createFilteredIterator(status: string): Iterator<CheckItem> {
    const filtered = this.items.filter(item => item.getStatus() === status);
    return new CheckListIterator(filtered);
  }
}

// 檢查系統管理器
class InspectionManager {
  private checkList = new CheckList();

  constructor() {
    // 添加測試資料
    this.checkList.addItem(new CheckItem("張三績效", "良好"));
    this.checkList.addItem(new CheckItem("李四績效", "優秀"));
    this.checkList.addItem(new CheckItem("電商專案", "進行中"));
    this.checkList.addItem(new CheckItem("預算使用", "超支"));
  }

  // 全面檢查
  conductFullInspection(): void {
    console.log("🔍 === 老闆的全面檢查 ===");
    
    const iterator = this.checkList.createIterator();
    let count = 0;

    while (iterator.hasNext()) {
      const item = iterator.next();
      if (item) {
        count++;
        console.log(`${count}. ${item.getDetails()}`);
        
        // 老闆的檢查邏輯
        if (item.getStatus() === "超支" || item.getStatus() === "待改進") {
          console.log(`   ⚠️  需要特別關注！`);
        }
      }
    }
    console.log(`✅ 檢查完成 (共 ${count} 項)\n`);
  }

  // 按狀態檢查
  inspectByStatus(status: string): void {
    console.log(`🎯 === 檢查「${status}」項目 ===`);
    
    const iterator = this.checkList.createFilteredIterator(status);
    let found = false;

    while (iterator.hasNext()) {
      const item = iterator.next();
      if (item) {
        console.log(`- ${item.getDetails()}`);
        found = true;
      }
    }
    
    if (!found) {
      console.log(`無「${status}」狀態項目`);
    }
    console.log();
  }
}

// 使用範例
const inspector = new InspectionManager();

// 全面檢查
inspector.conductFullInspection();

// 按狀態檢查
inspector.inspectByStatus("優秀");
inspector.inspectByStatus("超支");
```

## 生存技巧 🛡️

1. **Iterator 設計原則**：

   - **統一介面**：提供一致的遍歷方法
   - **狀態維護**：記錄當前遍歷位置
   - **封裝保護**：隱藏內部資料結構
   - **多重迭代**：支援同時進行多個遍歷

2. **與老闆溝通策略**：

   - **系統化強調**：展示如何有序且完整地檢查
   - **效率保證**：說明如何避免遺漏和重複
   - **靈活應用**：展示不同的遍歷和篩選方式
   - **進度可視**：提供檢查進度和狀態回饋

3. **技術實作要點**：

   - **異常處理**：處理遍歷過程中的例外情況
   - **記憶體效率**：大資料集的懶加載和分頁
   - **並行安全**：多執行緒環境下的迭代器安全
   - **擴展性**：支援不同的遍歷策略和順序

4. **架構決策建議**：
   - **內建支援**：善用語言內建的迭代器特性
   - **效能優化**：避免不必要的資料複製
   - **介面一致**：保持不同集合的迭代器介面統一
   - **生命週期**：管理迭代器的創建和銷毀

## 明日預告 🔮

明天我們將探討 **Interpreter Pattern - 語言翻譯官**，學習如何應對老闆的溝通障礙：「我講的話你們要能理解並執行！」

準備迎接語言解析的挑戰！ 🗣️
