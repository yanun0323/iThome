在寫業務邏輯程式碼前，我習慣先定義出資料，及規劃大概的業務邏輯流程。

# 定義資料
---
我們待辦事項資料預想會有一些欄位：
- 待辦事項名稱
- 建立日期
- 是否完成
- `其他未來可以擴充的欄位...`

設定好之後就可以定義資料了。
我們在 `Model` 資料夾內新建一個 `TodoEvent.swift`，並實作 `Migrator`：
```swift
import Foundation
import SQLite
import Sworm

struct TodoEvent {
    var id: Int64
    var title: String
    var createAt: Date
    var complete: Bool
}

extension TodoEvent: Migrator {
    static var table: Tablex { Tablex("events") }
    
    static let id = Expression<Int64>("id")
    static let title = Expression<String>("title")
    static let createAt = Expression<Date>("create_at")
    static let complete = Expression<Bool>("complete")
    
    static func migrate(_ db: Connection) throws {
        try db.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: true)
            t.column(title)
            t.column(createAt)
            t.column(complete)
        })
    }
    
    static func parse(_ row: Row) throws -> TodoEvent {
        return TodoEvent(
            id: try row.get(id),
            title: try row.get(title),
            createAt: try row.get(createAt),
            complete: try row.get(complete)
        )
    }
    
    func setter() -> [Setter] {
        return [
            TodoEvent.title <- title,
            TodoEvent.createAt <- createAt,
            TodoEvent.complete <- complete
        ]
    }
}
```

# 規劃業務邏輯流程
---
目前這一版 App 只會規劃新增跟刪除待辦事項。

> 筆者習慣使用 [**Mermaid**](https://mermaid.js.org) 來畫流程圖。

### 新增待辦事項的流程
[![](https://mermaid.ink/img/pako:eNptkcFugzAMhl_F8mmTSh-AwyQY04S0y2DjEnqIwC2RIImCaTW1ffelSyp6WE7x__3xLztn7ExPmOLBSTvAV9Fq8KcRjaLTLhS5eHUkmSBfmI2OailKzeRkx8ZFKROZtTV7axQqUZE1OwhVkYun-vNDMT17HrTvmRwkyQvkMetWXN6OpPkCZUx61KrY-U-r5ZEggiK_p0Cy9eydOCA4KR5A9Y9vt_eGK1zD_oFZHDDAbBxD63l1NLjBidwkVe-3eb75W-SBJmox9dee9nIZucVWX71VLmzqH91hym6hDS6292srlPT_MGG6l-NM11_5MH9R?type=jpg)](https://mermaid.live/edit#pako:eNptkcFugzAMhl_F8mmTSh-AwyQY04S0y2DjEnqIwC2RIImCaTW1ffelSyp6WE7x__3xLztn7ExPmOLBSTvAV9Fq8KcRjaLTLhS5eHUkmSBfmI2OailKzeRkx8ZFKROZtTV7axQqUZE1OwhVkYun-vNDMT17HrTvmRwkyQvkMetWXN6OpPkCZUx61KrY-U-r5ZEggiK_p0Cy9eydOCA4KR5A9Y9vt_eGK1zD_oFZHDDAbBxD63l1NLjBidwkVe-3eb75W-SBJmox9dee9nIZucVWX71VLmzqH91hym6hDS6292srlPT_MGG6l-NM11_5MH9R)

### 刪除待辦事項的流程
[![](https://mermaid.ink/img/pako:eNpdkc9ugzAMxl_F8mmVSh8AVZ1A7IC0y2DjEnpIwZRIEFBwVlWl774wsr85xT9_9uc4N6yGmjDEs5FjC69JqcGdQhSKLsc1iEVCHTFBbJkH7WkqUs1kZMWD8SgS0TjmLJk8yERG43CENUpi8ZC_PCumjcuv7G0iA0FwgNh7LcGs6hlSb_MNMt_zE_iJnt5JM5yusAiS-MsHgp3T5LaqaJoef5f-5T8eu_89L4pb13V_MgfVgC-ZIfIvXSuirlvlLlPgFnsyvVS1W-dt0ZXILfVUYuiuNTXSdlxiqe9OKi0P-VVXGLKxtEU71m5viZLuI3oMG9lNdP8APVB_rA?type=jpg)](https://mermaid.live/edit#pako:eNpdkc9ugzAMxl_F8mmVSh8AVZ1A7IC0y2DjEnpIwZRIEFBwVlWl774wsr85xT9_9uc4N6yGmjDEs5FjC69JqcGdQhSKLsc1iEVCHTFBbJkH7WkqUs1kZMWD8SgS0TjmLJk8yERG43CENUpi8ZC_PCumjcuv7G0iA0FwgNh7LcGs6hlSb_MNMt_zE_iJnt5JM5yusAiS-MsHgp3T5LaqaJoef5f-5T8eu_89L4pb13V_MgfVgC-ZIfIvXSuirlvlLlPgFnsyvVS1W-dt0ZXILfVUYuiuNTXSdlxiqe9OKi0P-VVXGLKxtEU71m5viZLuI3oMG9lNdP8APVB_rA)

業務邏輯流程規劃出來之後，就會比較知道實際的邏輯要怎麼寫，會遇到什麼問題。

# 總結
---
資料定義跟業務邏輯規劃，雖然沒有碰到程式碼，但對寫程式碼的幫助超乎想像的大。

試著用紙筆或 [**Mermaid**](https://mermaid.js.org) 把你的流程畫下來吧！