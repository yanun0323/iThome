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
            championMembers()
            fmvp()
        }
    }
    
    @ViewBuilder
    private func championMembers() -> some View {
        VStack(spacing: .globalSpacingSmall) {
            title("Champion Members")
            listBlock {
                ForEach(champion) { member in
                    listContent(member.name)
                }
            }
        }
    }
    
    @ViewBuilder
    private func fmvp() -> some View {
        VStack(spacing: .globalSpacingSmall) {
            title("FMVP")
            listBlock {
                listContent(champion[1].name)
            }
        }
    }
    
    @ViewBuilder
    private func title(_ title: String) -> some View {
        Text(title)
            .font(.system(.title, weight: .heavy))
            .foregroundColor(.primary)
    }
    
    @ViewBuilder
    private func listContent(_ name: String) -> some View {
        HStack {
            Image(systemName: "person.fill")
            Text("This is \(name)")
                .font(.system(.title3, weight: .medium))
        }
        .foregroundColor(.white)
    }
    
    @ViewBuilder
    private func listBlock(_ content: () -> some View) -> some View {
        VStack(alignment: .leading) {
            content()
        }
        .padding(.globalSpacingMedium)
        .background(Color.purple)
        .cornerRadius(7)
        .padding(.globalSpacingSmall)
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
