# Day 26: Interpreter Pattern - 語言翻譯官

## 老闆語錄 💬

> "我講的話你們要能理解並執行！『如果業績大於目標且客戶滿意度超過80分就發獎金』，系統要能聽懂這種邏輯！"

## 災難現場 🔥

週五下午的規則制定會議，老闆站在白板前，手裡拿著麥克筆，準備制定新的業務規則。

「各位！」老闆清了清嗓子，「我們要建立『智能業務規則系統』！」

HR 主管小陳好奇地問：「什麼意思？」

老闆開始在白板上寫字：「我要能用『自然語言』制定規則！比如說...」

他寫下：「如果 業績 > 目標 且 滿意度 >= 80 則 發放獎金」

「還有！」老闆繼續寫：「如果 遲到次數 > 3 或 請假天數 > 10 則 扣除績效獎金」

「再來！」他又寫：「如果 專案進度 < 50% 且 剩餘時間 < 30天 則 啟動緊急支援」

財務主管老趙困惑地看著白板：「這些規則要怎麼讓系統理解？」

「這就是重點！」老闆眼神發亮，「我要一個『規則翻譯器』！我用中文寫規則，系統自動理解並執行！」

系統分析師小莉疑惑地問：「但是每個規則的邏輯結構都不一樣...」

「沒關係！」老闆興奮地說，「翻譯器要很聰明！知道『如果...則...』是條件判斷，『且』是AND，『或』是OR，『>』是大於比較！」

他繼續解釋：「就像Google翻譯一樣！我輸入中文，它能理解語法結構，轉換成系統能執行的程式！」

產品經理阿凱試圖理解：「所以是要解析自然語言？」

「對！但不只解析！」老闆總結，「還要能執行！我說『如果業績大於100萬則發1萬獎金』，系統要能自動檢查所有員工，符合條件的就發獎金！」

前端工程師小美問：「那規則變更怎麼辦？」

「直接改規則描述就好！」老闆拍手，「不用改程式碼，不用重新部署，直接修改規則文字，系統立刻理解新規則！」

你突然明白了，老闆在描述 **Interpreter Pattern** - **為語言定義文法表示，並定義一個解釋器來處理這個文法**！

## 模式解析 🧠

Interpreter Pattern（解釋器模式）是行為型設計模式中的語言大師，它的核心思想是：**給定一個語言，定義它的文法表示，並定義一個解釋器，這個解釋器使用該表示來解釋語言中的句子**。

在我們的語言翻譯災難中，老闆的規則系統需求完美地展現了 Interpreter Pattern 的本質：

1. **語法定義**：定義規則語言的文法結構
2. **語句解析**：將自然語言轉換成可執行結構
3. **動態執行**：即時解釋並執行規則
4. **擴展靈活**：容易添加新的語法元素

Interpreter Pattern 的核心組件：

- **AbstractExpression**：抽象表達式，定義解釋介面
- **TerminalExpression**：終端表達式，實作文法中的終端符號
- **NonterminalExpression**：非終端表達式，實作文法規則
- **Context**：上下文，包含解釋器之外的全域資訊
- **Client**：客戶端，建立抽象語法樹並調用解釋

適用情境：

- **DSL 實作**：領域特定語言的設計和實作
- **規則引擎**：業務規則的動態配置和執行
- **查詢語言**：自定義查詢語法的解析
- **配置文件**：複雜配置的語法解析

## 程式碼範例 💻

讓我們實作一個「業務規則解釋器」，展示 Interpreter Pattern 的核心概念：

```ts
// 上下文：包含變量和數據
class Context {
  private variables: Map<string, number> = new Map();

  setVariable(name: string, value: number): void {
    this.variables.set(name, value);
  }

  getVariable(name: string): number {
    return this.variables.get(name) || 0;
  }
}

// 抽象表達式
abstract class Expression {
  abstract interpret(context: Context): boolean | number;
}

// 終端表達式：變量
class VariableExpression extends Expression {
  constructor(private name: string) {
    super();
  }

  interpret(context: Context): number {
    return context.getVariable(this.name);
  }
}

// 終端表達式：數字
class NumberExpression extends Expression {
  constructor(private value: number) {
    super();
  }

  interpret(context: Context): number {
    return this.value;
  }
}

// 非終端表達式：比較運算
class ComparisonExpression extends Expression {
  constructor(
    private left: Expression,
    private operator: string,
    private right: Expression
  ) {
    super();
  }

  interpret(context: Context): boolean {
    const leftValue = this.left.interpret(context) as number;
    const rightValue = this.right.interpret(context) as number;

    switch (this.operator) {
      case '>': return leftValue > rightValue;
      case '<': return leftValue < rightValue;
      case '>=': return leftValue >= rightValue;
      default: return false;
    }
  }
}

// 規則引擎
class RuleEngine {
  // 簡化的規則解析
  parseAndEvaluate(rule: string, context: Context): boolean {
    // 解析 "如果 業績 > 100 則 發獎金"
    const match = rule.match(/如果\s+(\w+)\s*([><=]+)\s*(\d+)\s+則\s+(.+)/);
    
    if (match) {
      const variable = new VariableExpression(match[1]);
      const operator = match[2];
      const value = new NumberExpression(parseInt(match[3]));
      const action = match[4];

      const condition = new ComparisonExpression(variable, operator, value);
      const result = condition.interpret(context) as boolean;

      if (result) {
        console.log(`🎯 規則觸發: ${action}`);
        return true;
      } else {
        console.log(`❌ 條件不滿足: ${rule}`);
        return false;
      }
    }
    
    console.log(`❌ 規則格式錯誤: ${rule}`);
    return false;
  }
}

// 使用範例
const context = new Context();
context.setVariable("業績", 150);
context.setVariable("滿意度", 85);
context.setVariable("遲到次數", 2);

const ruleEngine = new RuleEngine();

console.log("=== 老闆的智能規則系統 ===");

// 測試各種規則
ruleEngine.parseAndEvaluate("如果 業績 > 100 則 發放獎金", context);
ruleEngine.parseAndEvaluate("如果 滿意度 >= 80 則 給予表揚", context);
ruleEngine.parseAndEvaluate("如果 遲到次數 > 5 則 扣薪水", context);
```

## 生存技巧 🛡️

1. **Interpreter 設計原則**：

   - **語法清晰**：定義明確的文法規則
   - **遞迴結構**：利用語法樹的遞迴特性
   - **擴展容易**：新增語法元素不影響現有結構
   - **錯誤處理**：提供友好的錯誤訊息

2. **與老闆溝通策略**：

   - **自然語言**：強調能用日常語言制定規則
   - **即時生效**：展示規則修改的即時性
   - **可視化**：提供規則執行的清晰回饋
   - **靈活性**：說明如何快速適應業務變化

3. **技術實作要點**：

   - **解析效率**：複雜語法可能影響解析效能
   - **記憶體管理**：語法樹可能佔用大量記憶體
   - **安全性**：防止惡意或錯誤的規則執行
   - **除錯支援**：提供規則執行的除錯資訊

4. **架構決策建議**：
   - **適用評估**：確認是否真的需要自定義語言
   - **替代方案**：考慮現有的規則引擎或DSL
   - **維護成本**：評估語法維護的長期成本
   - **效能權衡**：解釋執行 vs 編譯執行的選擇

## 明日預告 🔮

明天我們將探討 **Null Object Pattern - 空氣員工**，學習如何應對老闆的虛位以待哲學：「這個位置要有人，但可以什麼都不做！」

準備迎接無害存在的挑戰！ 👻
