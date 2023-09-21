import SwiftUI

struct ContentView: View {
    var champion: [Member] = [
        Member(name:"Faker"),
        Member(name:"MaRin"),
        Member(name:"Bengi"),
        Member(name:"Bang"),
        Member(name:"Wolf"),
        Member(name:"kkOma")
    ]
    
    var body: some View {
        VStack {
            ForEach(champion) { member in
                Text("This is \(member.name)")
            }
        }
    }
}

struct Member: Identifiable {
    var id = UUID()
    var name: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
