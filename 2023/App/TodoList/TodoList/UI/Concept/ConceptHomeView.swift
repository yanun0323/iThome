import SwiftUI
import Ditto

struct ConceptHomeView: View {
    @State private var data = ["A", "B", "C"]
    @State private var showAdderView = false
    @State private var input = ""
    
    var body: some View {
        VStack {
            titleView()
            listView()
            Spacer()
            adderButtonView()
        }
        .sheet(isPresented: $showAdderView) {
            input = ""
        } content: {
            adderView()
        }
    }
    
    @ViewBuilder
    private func adderView() -> some View {
        VStack(alignment: .leading) {
            Text("新增代辦事項")
                .font(.system(.title, design: .rounded, weight: .medium))
            TextField("preparing dinner", text: $input)
                .textFieldStyle(.plain)
                .font(.system(.title3, design: .rounded, weight: .medium))
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            Spacer()
            HStack {
                Button(width: 150, height: 45, color: .gray, radius: 10) {
                    showAdderView = false
                } content: {
                    Text("取消")
                        .foregroundColor(.white)
                        .font(.title3)
                }
                Spacer()
                Button(width: 150, height: 45, color: .purple, radius: 10) {
                    showAdderView = false
                    if input.count != 0 {
                        withAnimation {
                            data.append(input)
                        }
                    }
                } content: {
                    Text("新增")
                        .foregroundColor(.white)
                        .font(.title3)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .presentationDetents([.height(200)])
    }
    
    
    @ViewBuilder
    private func adderButtonView() -> some View {
        Button {
            showAdderView = true
        } label: {
            Circle()
                .foregroundColor(.purple)
                .frame(width: 80)
                .shadow(color: .black.opacity(0.2), radius: 15)
                .overlay {
                    Image(systemName: "plus")
                        .font(.system(.largeTitle, design: .rounded, weight: .medium))
                        .foregroundColor(.white)
                }
        }
    }
    
    @ViewBuilder
    private func titleView() -> some View {
        HStack {
            Text("Todo List")
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            Spacer()
            Text(data.count.description)
                .font(.system(.title, design: .rounded, weight: .bold))
        }
        .foregroundColor(.purple)
        .padding()
    }
    
    @ViewBuilder
    private func listView() -> some View {
        List {
            ForEach(data, id: \.self) { d in
                HStack {
                    Text(d)
                        .font(.title3)
                    Spacer()
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        print("delete \(d)")
                    } label: {
                        Image(systemName: "trash.fill")
                    }

                }
            }
        }
        .listStyle(.plain)
    }
    
}

struct ConceptHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ConceptHomeView()
    }
}
