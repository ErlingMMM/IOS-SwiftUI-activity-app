import Foundation


struct SavedActivitiesModel: Codable, Identifiable {
    let activity: String
    let accessibility: Float
    let type: String
    let participants: Int
    let price: Float
    let link: String
    let key: String
    let date: Date
    
    var id: String {
        key
    }
}

