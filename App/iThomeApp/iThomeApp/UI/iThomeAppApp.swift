import SwiftUI

@main
struct iThomeAppApp: App {
    private var container = DIContainer()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.injected, container)
        }
    }
}
