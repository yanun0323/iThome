import SwiftUI

class Person: ObservableObject {
    @Published var name: String
    @Published var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

struct ContentView: View {
    @StateObject private var person = Person(name: "Faker", age: 5)
    
    var body: some View {
        VStack {
            Text("ContentView")
                .font(.title)
            Text("Age: \(person.age)")
            Button("Add Age") {
                person.age += 1
            }
            .buttonStyle(.borderedProminent)
            
            AnotherView(person: person)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


