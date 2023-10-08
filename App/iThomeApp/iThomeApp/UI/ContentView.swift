import SwiftUI


struct ContentView: View {
    @Environment(\.injected) private var container: DIContainer
    @State private var members = [Member]()
    
    var body: some View {
        VStack {
            memberList()
            TestButton()
        }
        .onReceive(container.appState.members) { members = $0 ?? [] }
        .onAppear { container.interactor.member.getAllMember() }
    }
    
    @ViewBuilder
    private func memberList() -> some View {
        VStack {
            if members.isEmpty {
                Text("Empty Member!")
            } else {
                ForEach(members, id: \.id) { member in
                    Text("\(member.id)")
                        .lineLimit(1)
                    Text("\(member.name)")
                        .lineLimit(1)
                    Text("\(member.position.rawValue)")
                        .lineLimit(1)
                }
            }
        }
    }
    
    @ViewBuilder
    private func TestButton() -> some View {
        Button("Test Push Members") {
            let random = Member(id: Int64.random(in: 1...Int64.max), name: UUID().uuidString, position: .Mid)
        
            _ = container.interactor.member.saveMember(random)
        }
        .buttonStyle(.borderedProminent)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.injected, DIContainer(isMock: true))
    }
}
