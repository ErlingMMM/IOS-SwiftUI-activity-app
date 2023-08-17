import SwiftUI


//Nester CompletedActivitiesView inn i en klasse som er et ObservableObject, for å kunne oppdatere det visuelle med en gang endringer gjøres.
class RegisterViewModel: ObservableObject {
    let defaults = UserDefaults.standard
    let arrayKey = "arrayKey"
    @Published var activityRegister: [SavedActivitiesModel] = []
    
    //Formatering av dato for filtreringen. Kun dato, ikke klokkeslett
    var dateFormatterFilter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    
    //Henter alle datoer fra data modellen. Lagrer alle unike datoer i et Dictionary som er kjørt i DateFormatter.Disse sorteres så slik at de nyeste datoene dukker opp øverst i appen.
    var groupedActivitiesByDate: [(dateString: String, activities: [SavedActivitiesModel])] {
        //https://developer.apple.com/documentation/swift/dictionary/init(grouping:by:)
        let groupedDates = Dictionary(grouping: activityRegister, by: { dateFormatterFilter.string(from: $0.date) })
        //https://developer.apple.com/documentation/swiftui/binding/sorted(by:)
        return groupedDates.sorted(by: { $0.key > $1.key }).map { ($0.key, $0.value) }
    }
    
    
    //Laster alle aktiviter lagret på telefonen. Looper først igjennom arrayet med unike UUID, før den henter alle objekter som har de ulike UUID som keys.
    func loadActivitiesSavedOnPhone() {
        // Lager et tomt array for å unngå duplikasjoner
        var savedActivities: [SavedActivitiesModel] = []
        if let uuidArray = UserDefaults.standard.array(forKey: arrayKey) as? [String] {
            for uuid in uuidArray {
                //https://www.hackingwithswift.com/example-code/system/how-to-load-and-save-a-struct-in-userdefaults-using-codable
                if let data = UserDefaults.standard.data(forKey: uuid),
                   let loadedActivity = try? JSONDecoder().decode(SavedActivitiesModel.self, from: data) {
                    savedActivities.append(loadedActivity)
                }
            }
        }
        activityRegister = savedActivities
    }
    
    
    
    //Looper igjennom alle UUID. Hvis de finnes, så slettes objektet med den gitte UUID. Til slutt slettes alle UUID i UUID array, før activityRegister også tømmes for innhold
    fileprivate func deleteActivityObjectsAndUUID() {
        if let uuidArray = UserDefaults.standard.array(forKey: arrayKey) as? [String] {
            for uuid in uuidArray {
                //https://www.hackingwithswift.com/example-code/system/how-to-load-and-save-a-struct-in-userdefaults-using-codable
                
                if let data = UserDefaults.standard.data(forKey: uuid),
                   let _ = try? JSONDecoder().decode(SavedActivitiesModel.self, from: data) {
                    UserDefaults.standard.removeObject(forKey: uuid)
                }
            }
            UserDefaults.standard.removeObject(forKey: arrayKey)
            activityRegister = []
        }
    }
}




struct CompletedActivitiesView: View {
    @StateObject var registerViewModel = RegisterViewModel()
    
    //Eget datoformat for å vise dato feltet i de ulike aktvitetene.
    var dateFormatterVisual: DateFormatter = {
        //https://developer.apple.com/documentation/foundation/dateformatter
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMMdEEEE")
        return formatter
    }()
    
    
    //Summering av alle verdier i pris propertiet.
    //https://stackoverflow.com/questions/43911721/sum-values-of-properties-inside-array-of-custom-objects-using-reduce
    var totalAmountUsedOnActivities: Float {
        registerViewModel.activityRegister.reduce(0.0, { $0 + $1.price })
    }
    
    
    
    fileprivate func viewActivitiesGrid() -> some View {
        
        return ScrollView {
            LazyVGrid(columns: [GridItem(.flexible())]) {
                //Looper først igjennom alle unike datoer
                ForEach(registerViewModel.groupedActivitiesByDate, id: \.dateString) { groupByDate in
                    Section(header: Text("Aktiviter med dato: \(groupByDate.dateString)")
                        .bold()
                    ){
                        // //https://stackoverflow.com/questions/61827511/how-do-i-sum-values-from-a-list-in-swiftui
                        let sum = groupByDate.activities.map { $0.price }.reduce(0, +)
                        Text("Penger brukt denne dagen: \(sum, specifier: "%.1f") dollar")
                        //Looper alle lagrede aktiviteter, men filtrer på dato.
                        ForEach(registerViewModel.activityRegister.indices.filter {registerViewModel.dateFormatterFilter.string(from: registerViewModel.activityRegister[$0].date)  == groupByDate.dateString }, id: \.self) { index in
                            //En måte å sikre at man kan legge til samme aktivit med samme key på nytt.  (For eksempel på ulike datoer)
                            
                            let task = registerViewModel.activityRegister[index]
                            NavigationLink(
                                destination: SavedActivityDetailView(task: task)) {
                                    
                                    VStack(alignment: .leading) {
                                        Text("Navn: \(task.activity)")
                                        Text("Key: \(task.key)")
                                        Text("Dato: \(dateFormatterVisual.string(from: task.date).capitalized)")
                                        Text("Tilgjengelighet: \(String(format: "%.1f", task.accessibility))")
                                        Text("Type: \(task.type.capitalized)")
                                        Text("Antall deltakere: \(task.participants)")
                                        Text((task.price > 0.0 ? "Pris:  \(String(format: "%.1f",  task.price ))" : "Gratis!"))
                                        Text("Link: " + (task.link == "" ? "Har ikke link" : "\(task.link)"))
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                }
                        }
                    }
                    
                }
            }
        }
    }
    
    
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Button(action: {
                    registerViewModel.deleteActivityObjectsAndUUID()
                }) {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.red, lineWidth: 2)
                        .frame( height: 40)
                        .padding(.horizontal, 70)
                        .overlay(
                            Text("Tøm register")
                                .foregroundColor(Color.red)
                        )
                }
                
                Text("Totalt beløp brukt: \(String(format: "%.1f", totalAmountUsedOnActivities)) dollar")
                    .font(.headline)
                Spacer()
                Spacer()
                
                viewActivitiesGrid()
                
                
            }
            .navigationBarTitle("Gjennomførte aktiviter", displayMode: .inline)
            .frame(maxWidth: .infinity)
            .onAppear {
                registerViewModel.loadActivitiesSavedOnPhone()
            }
        }
    }
}
























