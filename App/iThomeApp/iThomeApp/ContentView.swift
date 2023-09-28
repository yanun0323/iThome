import SwiftUI

struct ContentView: View {
    @State private var showPopover: Bool = false
    var body: some View {
        VStack {
            Button {
                showPopover = true
            } label: {
                Text("Show Popover")
            }
            .buttonStyle(.borderedProminent)
        }
        .popover(isPresented: $showPopover, arrowEdge: .top) {
            Text("Hello")
                .presentationDetents([.medium, .large])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


