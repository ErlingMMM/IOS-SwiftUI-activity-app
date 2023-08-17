import SwiftUI

struct ContentView: View {

    
    var body: some View {
        NavigationView {
            TabView {
                NewActivityView()
                    .tabItem {
                        //https://sfsymbols.com/
                        Image(systemName: "lightbulb.fill")
                        Text("Ny aktivitet")
                    }
                
                CompletedActivitiesView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Gjennomførte")
                    }
                }
            .accentColor(.blue)
            .navigationTitle("Aktivitets App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







