import SwiftUI

struct ContentView: SwiftUI.View {
    @Environment(\.injected) private var container: DIContainer
    
    var body: some SwiftUI.View {
        Text("Hello")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        ContentView()
    }
}
