import SwiftUI
import SQLite

struct ContentView: SwiftUI.View {
    @State private var db: Connection
    
    init() {
        self.db = try! Connection(.inMemory)
        do {
            try createMemberTable(db)
        } catch {
            print(error)
            return
        }
        print("member table created")
    }
    
    var body: some SwiftUI.View {
        Text("Hello")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
