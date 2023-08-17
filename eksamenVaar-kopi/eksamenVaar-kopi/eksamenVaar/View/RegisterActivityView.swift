import SwiftUI



struct RegisterActivityView: View {
    @Binding var isFullScreenCoverPresented: Bool
    @State var isCalendarPresented = false
    @State private var addedToLog = false
    @State var date = Date()
    let task: ActivityModel
    
    
    var dateFormatter: DateFormatter = {
        //https://developer.apple.com/documentation/foundation/dateformatter
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMMdEEEE")
        return formatter
    }()
    
    
    
    fileprivate func logActivity() {
        
        //https://stackoverflow.com/questions/69457154/swiftui-navigationview-timer-delay
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            isFullScreenCoverPresented = false
        }
        addedToLog = true
        onPhoneSaveUUIDArr()
    }
    
    
    //Lagrer UUID array i UserDefaults for å bruke som en unik key for hvert objekt/aktivitet. Legger også til i dette arrayet for hver nye aktvitet.
    fileprivate func onPhoneSaveUUIDArr() {
        let uuid = UUID().uuidString
        var uuidArray = [String]()
        
        //https://stackoverflow.com/questions/25179668/how-to-save-and-read-array-of-array-in-nsuserdefaults-in-swift
        if let savedArray = UserDefaults.standard.array(forKey: "arrayKey") as? [String] {
            uuidArray = savedArray
        }
        uuidArray.append(uuid)
        UserDefaults.standard.set(uuidArray, forKey: "arrayKey")
        saveActivity(forKey: uuid)
    }
    
    
    
    
    //Lagrer hvert objekt i UserDefaults
    fileprivate func saveActivity(forKey uuidKey: String) {
        let savedActivities = SavedActivitiesModel(activity: task.activity, accessibility: task.accessibility, type: task.type, participants: task.participants, price: task.price, link: task.link, key: task.key, date: date)
        
        //https://www.hackingwithswift.com/example-code/system/how-to-load-and-save-a-struct-in-userdefaults-using-codable
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedActivities) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: uuidKey)
        }
        
    }
    
    
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Registrer at du har gjort aktiviteten:")
                .bold()
            Text("\(task.activity)")
            
            Button(action: {
                isCalendarPresented = true
            }) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 200, height: 40)
                    .overlay(
                        Text("\(dateFormatter.string(from: date).capitalized)")
                            .foregroundColor(Color.blue)
                    )
            }
            
            Button(action: logActivity) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
                    .frame(width: 160, height: 40)
                    .overlay(
                        Text("Registrer")
                            .foregroundColor(Color.blue)
                    )
            }
            
            //Gir brukeren melding om at aktiviteten er blitt lagret
            Text(addedToLog ? "Registrert" : "")
                .bold()
                .font(.headline)
            
            
            
                .fullScreenCover(isPresented: $isCalendarPresented) {
                    CalendarView(date: $date, isCalendarPresented: $isCalendarPresented)
                }
            
            
            Button(action: {
                isFullScreenCoverPresented = false
            }) {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.red, lineWidth: 2)
                    .frame(width: 160, height: 40)
                    .overlay(
                        Text("Avbryt")
                            .foregroundColor(Color.red)
                    )
            }
        }
        //Nullstiller meldingen brukeren får om at aktivitene er registert
        .onAppear {
            addedToLog = false
        }
    }
}



