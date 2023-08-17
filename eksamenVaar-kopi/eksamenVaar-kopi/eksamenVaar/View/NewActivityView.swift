import SwiftUI



struct NewActivityView: View {
    @StateObject var viewActivityModel = ViewActivityModel()
    @State var isLoading = true
    @State var isFullScreenCoverPresented = false
    @State var isFiltered = false
    @State var numberOfParticipants = 0
    @State var userInputNumberOfParticipants = 0
    @State var errorMessage = ""
    
    
    fileprivate func animationWhileLoading() {
        if isFiltered {
            //Alterntiv for å bli kvitt advarsel. Men da ville filter oppdatere seg tregere og brukeren måtte ha trykket to ganger på Finn ny aktivitet først, i stedet for en gang.
            /* DispatchQueue.main.async {
             viewActivityModel.filterByParticipants = numberOfParticipants
             }*/
            
            viewActivityModel.filterByParticipants = numberOfParticipants
            isFiltered = false
        }
        isLoading = true
        //Loader data fra API
        viewActivityModel.loadDataFromAPI()
        //Et lite delay slik at load screen skal være mulig å se, da API kallet gikk veldig fort ellers.
        //https://stackoverflow.com/questions/69457154/swiftui-navigationview-timer-delay
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            isLoading = false
        }
    }
    
    fileprivate func shouldShowActivityList() -> AnyView {
        if isLoading {
            return AnyView(loadView())
        } else {
            return AnyView(activityList())
        }
    }
    
    fileprivate func loadView() -> some View {
        ProgressView("Henter ny aktivitet")
            .scaleEffect(1.5)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        //https://developer.apple.com/forums/thread/652733
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            .foregroundColor(.blue)
    }
    
    
    
    fileprivate func activityList() -> some View {
        return List(viewActivityModel.activities, id: \.key) { task in
            Text("Navn: " + task.activity)
            Text("Tilgjengelighet: \(String(format: "%.1f", task.accessibility))")
            Text("Type: \(task.type.capitalized)")
            Text((task.price > 0.0 ? "Pris:  \(String(format: "%.1f",  task.price ))" : "Gratis!"))
            Text("Antall deltakere: \(task.participants)")
            Text("Link: " + (task.link == "" ? "Har ikke link" : "\(task.link)"))
            Text("Key: " + task.key)
            
            
            Button(action: {
                if userInputNumberOfParticipants > 0 && userInputNumberOfParticipants < 101 {
                    UserDefaults.standard.set(userInputNumberOfParticipants, forKey: "numberOfParticipants")
                    isFiltered = true
                    numberOfParticipants = userInputNumberOfParticipants
                    userInputNumberOfParticipants = 0
                    animationWhileLoading()
                    errorMessage = ""
                    
                    
                    //NB. DET STOD STØRRE ENN 100 I OPPGAVEN. Gir kun advarsel ved 101 eller høyere tall.
                    
                } else if userInputNumberOfParticipants > 100 {
                    errorMessage = "Du må velge et tall mellom 1 og 100"
                }else{
                    errorMessage = ""
                    animationWhileLoading()
                }
            }) {
                Text("Finn ny aktivitet")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
            
            
            TextField(
                "",
                value: $userInputNumberOfParticipants,
                formatter: NumberFormatter()
            )
            .textInputAutocapitalization(.none)
            .border(.secondary)
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .keyboardType(.numberPad)
            
            
            
            Button(action: {
                isFullScreenCoverPresented = true
            }) {
                Text("Registrer gjennomført aktivitet")
                    .bold()
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                Text("Aktivitet")
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .padding()
                
                shouldShowActivityList()
                
                
                Text("\(errorMessage)")
                    .foregroundColor(Color.red)
                
                //Knapp for å skru av filter. Hvis filter allerede er av, skal ikke knappen gjøre noe funksjonelt
                Button(viewActivityModel.filterByParticipants > 0 ? "Deaktiver filter" : "Filter er av") {
                    if viewActivityModel.filterByParticipants > 0 {
                        viewActivityModel.filterByParticipants = 0
                        animationWhileLoading()
                    }
                }
                .frame(maxWidth: .infinity)
                .bold()
                .foregroundColor(viewActivityModel.filterByParticipants > 0 ? .red : .gray)
            }
            .onAppear {
                animationWhileLoading()
            }
            .navigationTitle("Ny aktivitet")
        }
        
        .fullScreenCover(isPresented: $isFullScreenCoverPresented) {
            //Skjekker først om viewActivityModel.activities
            if let task = viewActivityModel.activities.first {
                RegisterActivityView(isFullScreenCoverPresented: $isFullScreenCoverPresented, task: task)
            }
        }
    }
}






















