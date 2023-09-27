import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            ForEach(1...100, id: \.self) { number in
                HStack {
                    Spacer()
                    Text("\(number)")
                        .font(.largeTitle)
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


