import SwiftUI

struct SavedActivityDetailView: View {
    @State private var emojiPosition = CGPoint()
    let task: SavedActivitiesModel
    
    var body: some View {
        VStack {
            ZStack {
                Text(task.price == 0 ? "💯" : "☑️")
                    .font(.system(size: 60))
                    .position(emojiPosition)
                    .animation(Animation.easeIn(duration: 10))
                    .zIndex(1)
                
                
                List {
                    Text("Navn: " + task.activity)
                    Text("Tilgjengelighet: \(String(format: "%.1f", task.accessibility))")
                    Text("Type: \(task.type.capitalized)")
                    Text((task.price > 0.0 ? "Pris:  \(String(format: "%.1f",  task.price ))" : "Gratis!"))
                    Text("Antall deltakere: \(task.participants)")
                    Text("Link: " + (task.link == "" ? "Har ikke link" : "\(task.link)"))
                    Text("Key: " + task.key)
                }
            }
            Spacer()
        }
        .onAppear {
            self.emojiPosition = CGPoint(x: 400, y: UIScreen.main.bounds.height + 60)
        }
    }
}
