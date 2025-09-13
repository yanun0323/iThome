import SwiftUI
import Ditto

@main
struct TodoListApp: App {
    let container = DIContainer(isMock: false)
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .inject(container)
        }
    }
}
