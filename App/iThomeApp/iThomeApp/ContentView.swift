import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Text("Button B")
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
                .background(Color.red)
                .cornerRadius(15)
                .onTapGesture {
                    print("This is Button B")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
