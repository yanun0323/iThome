import SwiftUI


struct ContentView: View {
    @Environment(\.injected) private var container: DIContainer
    @State private var members = [Member]()
    
    var body: some View {
        VStack {
            memberList()
            TestButton()
        }
        .onReceive(container.appState!.members) { members = $0 ?? [] }
    }
    
    @ViewBuilder
    private func memberList() -> some View {
        VStack {
            if members.isEmpty {
                Text("Empty Member!")
            } else {
                ForEach(members, id: \.id) { member in
                    Text("\(member.id) \(member.name)")
                }
            }
        }
    }
    
    @ViewBuilder
    private func TestButton() -> some View {
        Button("Test Push Members") {
            let randomID = Int64.random(in: 1...50)
            container.appState?.members.send([
                Member(id: randomID, name: "Faker", position: .Mid),
                Member(id: 50 - randomID, name: "MaRin", position: .Top)
            ])
        }
        .buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.injected, DIContainer(appState: AppState()))
    }
}
