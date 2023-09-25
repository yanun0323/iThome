import SwiftUI

struct AnotherView: View {
    @ObservedObject var person: Person
    
    var body: some View {
        VStack {
            Text("AnotherView")
                .font(.title)
            Text("Age: \(person.age)")
            Button("Add Age") {
                person.age += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .border(Color.red)
    }
}

struct AnotherView_Previews: PreviewProvider {
    static var previews: some View {
        AnotherPreview(person: Person(name: "Faker", age: 5))
    }
}

struct AnotherPreview: View {
    @State var person: Person
    var body: some View {
        AnotherView(person: person)
    }
}
