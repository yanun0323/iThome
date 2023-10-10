import SwiftUI
import Ditto



struct DittoView: View {
    var date = Date(from: "2006-01-02", .Date, .tw, .utc)
    
    var body: some View {
        VStack {
            Section("Title", font: .caption, color: .gray, radius: 15, bg: .section) {
                HStack {
                    Spacer()
                    Text("Content")
                    Spacer()
                }
                .padding()
            }
        }
        .padding()
    }
}

struct DittoView_Previews: PreviewProvider {
    static var previews: some View {
        DittoView()
    }
}
