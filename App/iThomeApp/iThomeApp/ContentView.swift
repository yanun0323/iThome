import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Faker! What was that!")
            .overlay {
                Image("Faker")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
