import SwiftUI
import Ditto

@main
struct iThomeAppApp: App {
    private var container = DIContainer()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .inject(container)
        }
    }
}
