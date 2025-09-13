# Day 17: Command Pattern - 指令歷史學家

## 老闆語錄 💬

> "我說過的每句話都要記錄下來！而且我改變心意的時候，要能一鍵撤回到之前的狀態！"

## 災難現場 🔥

週三下午的產品修改會議，老闆坐在會議桌前，面前擺著一疊修改建議，眼神專注地盯著螢幕上的系統介面。

「把這個按鈕改成紅色！」老闆第一個指令。

UI 設計師小美立刻動手修改：「好的，改成紅色了。」

過了五分鐘，老闆皺眉：「紅色太刺眼了，改成藍色！」

小美嘆氣，再次修改：「改成藍色了...」

又過了十分鐘：「藍色太冷淡，改成綠色！不對，綠色像錯誤訊息...改成橘色！」

小美已經快瘋了：「老闆，您到底要什麼顏色？」

「這樣好了！」老闆突然站起來，「我要一個『指令記錄系統』！把我說過的每個修改指令都記下來，包括時間、內容、執行結果！」

工程師小張困惑地問：「為什麼要記錄這些？」

「因為我要能『時光倒流』！」老闆眼神發亮，「當我說『撤回到 30 分鐘前的狀態』時，系統要能自動回到那個時間點的樣子！」

他在白板上畫了一條時間軸：「每個指令都是一個時間節點！我要能跳到任何一個節點！還要能『重做』被撤銷的操作！」

產品經理阿華擔心地說：「這樣不會很複雜嗎？」

「不複雜！」老闆越說越興奮，「就像錄音機一樣！播放、暫停、快轉、倒帶、重播！每個按鈕都是一個功能，每個功能都能獨立執行！」

測試工程師小李提出疑問：「那我們要怎麼知道每個指令的具體內容？」

「封裝啊！」老闆畫了一個個小盒子，「每個指令都是一個包裹！裡面有『做什麼』、『怎麼做』、『怎麼撤銷』！需要的時候就打開包裹執行！」

你恍然大悟，老闆其實是在描述 **Command Pattern** - **將請求封裝成物件，以便使用不同的請求、佇列或記錄請求來參數化其他物件**！

老闆最後總結：「我們要成為『操作歷史大師』！每個動作都能追蹤，每個決定都能反悔！」

## 模式解析 🧠

Command Pattern（命令模式）是行為型設計模式中的時光大師，它的核心思想是：**將請求封裝成物件，以便使用不同的請求、佇列或記錄請求來參數化其他物件，同時支援可撤銷操作**。

在我們的指令災難中，老闆的時光倒流需求完美地展現了 Command Pattern 的本質：

1. **請求封裝**：每個指令都是獨立的物件
2. **操作記錄**：所有操作都被記錄下來
3. **撤銷重做**：支援 Undo/Redo 功能
4. **參數化執行**：可以延遲執行或批次執行

Command Pattern 的核心組件：

- **Command**：命令介面，定義執行操作的方法
- **ConcreteCommand**：具體命令，實作 Command 介面
- **Receiver**：接收者，知道如何實施與執行請求
- **Invoker**：調用者，要求該命令執行請求

適用情境：

- **撤銷/重做功能**：文字編輯器、圖形軟體
- **操作記錄**：系統日誌、審計追蹤
- **佇列操作**：任務佇列、批次處理
- **巨集錄製**：記錄一系列操作供後續重播

## 程式碼範例 💻

讓我們實作一個「UI 修改指令系統」，展示 Command Pattern 的核心概念：

```ts
// 命令介面
interface Command {
  execute(): void;
  undo(): void;
}

// 接收者：文字編輯器
class TextEditor {
  private content: string = "";

  addText(text: string): void {
    this.content += text;
    console.log(`新增文字: "${text}"`);
  }

  removeText(length: number): void {
    this.content = this.content.slice(0, -length);
    console.log(`移除 ${length} 個字元`);
  }

  getContent(): string {
    return this.content;
  }
}

// 具體命令：新增文字
class AddTextCommand implements Command {
  private editor: TextEditor;
  private text: string;

  constructor(editor: TextEditor, text: string) {
    this.editor = editor;
    this.text = text;
  }

  execute(): void {
    this.editor.addText(this.text);
  }

  undo(): void {
    this.editor.removeText(this.text.length);
  }
}

// 調用者：指令管理器
class CommandManager {
  private history: Command[] = [];
  private currentIndex: number = -1;

  executeCommand(command: Command): void {
    command.execute();
    
    // 清除重做歷史
    this.history = this.history.slice(0, this.currentIndex + 1);
    this.history.push(command);
    this.currentIndex++;
  }

  undo(): void {
    if (this.currentIndex >= 0) {
      this.history[this.currentIndex].undo();
      this.currentIndex--;
      console.log("⏪ 撤銷操作");
    }
  }

  redo(): void {
    if (this.currentIndex < this.history.length - 1) {
      this.currentIndex++;
      this.history[this.currentIndex].execute();
      console.log("⏩ 重做操作");
    }
  }
}

// 使用範例
const editor = new TextEditor();
const manager = new CommandManager();

const cmd1 = new AddTextCommand(editor, "Hello ");
const cmd2 = new AddTextCommand(editor, "World!");

manager.executeCommand(cmd1);
manager.executeCommand(cmd2);
console.log("內容:", editor.getContent()); // "Hello World!"

manager.undo();
console.log("撤銷後:", editor.getContent()); // "Hello "

manager.redo();
console.log("重做後:", editor.getContent()); // "Hello World!"
```

## 生存技巧 🛡️

1. **Command 設計原則**：

   - **封裝完整性**：命令要包含執行所需的所有資訊
   - **撤銷支援**：每個命令都要支援 undo 操作
   - **狀態無關**：命令的執行不應依賴外部狀態
   - **原子性**：命令的執行應該是原子操作

2. **與老闆溝通策略**：

   - **歷史追蹤**：展示完整的操作歷史記錄
   - **即時反悔**：強調可以隨時撤銷任何操作
   - **批次操作**：說明巨集命令的效率優勢
   - **時光機效果**：演示跳轉到任意時間點的功能

3. **技術實作要點**：

   - **記憶體管理**：限制歷史記錄的長度避免記憶體洩漏
   - **序列化支援**：支援命令的序列化和反序列化
   - **錯誤處理**：優雅處理命令執行失敗的情況
   - **效能優化**：對於大量操作考慮使用快照機制

4. **架構決策建議**：
   - **持久化存儲**：考慮將歷史記錄持久化到資料庫
   - **併發控制**：多用戶環境下的命令衝突處理
   - **權限控制**：不同用戶的命令執行權限
   - **版本控制**：命令格式的版本兼容性

## 明日預告 🔮

明天我們將探討 **State Pattern - 心情氣象台**，學習如何應對老闆的情緒化決策：「我心情好的時候什麼都好說，心情不好時免談！」

準備迎接情緒管理的挑戰！ 🌦️

