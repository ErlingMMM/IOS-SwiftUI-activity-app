import SwiftUI

class ViewActivityModel: ObservableObject{
    // Her henter vi inn modellen ActivityModel
    @Published var activities = [ActivityModel]()
    
    @Published var filterByParticipants: Int = UserDefaults.standard.integer(forKey: "numberOfParticipants") {
        didSet {
            UserDefaults.standard.set(filterByParticipants, forKey: "numberOfParticipants")
        }
    }
    
    
    /*Ingen aktivitetet har 0 deltakere. Hadde det vært aktiviteter med 0 deltakere, kunne vi skrevet -1 her, og endret kodelinjen
     if filterByParticipants > -1  {*/
    
    // Dersom filterByParticipants settes til en verdi, vil det legges til en path i url, med bruker input
    var getUrl: String {
        let mainUrl = "https://www.boredapi.com/api/activity"
        if filterByParticipants > 0  {
            return mainUrl + "?participants=" + String(filterByParticipants)
        } else {
            return mainUrl
        }
    }
    
    
    
    //Laster dataene fra API. Denne må kalles på hver gang vi ønsker å oppdatere dataene vi mottar fra API.
    func loadDataFromAPI() {
        
        //https://www.youtube.com/watch?v=z_2iiq0MjmM&t=1s&ab_channel=ODENZA
        guard let url = URL(string: getUrl) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (dataAPI, res, err) in
            do {
                if let dataAPI = dataAPI {
                    //Endret slik at man tar inn kun et objekt og ikke et array
                    let resultData = try JSONDecoder().decode(ActivityModel.self, from: dataAPI)
                    DispatchQueue.main.async {
                        self.activities = [resultData]
                        
                    }
                } else {
                    print("No data from API")
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

