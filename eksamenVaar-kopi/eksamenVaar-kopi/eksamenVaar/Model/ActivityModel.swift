

import SwiftUI

//Modellen lager et objekt av dataene som hentes fra API
struct ActivityModel: Decodable {
    let activity: String
    let accessibility: Float
    let type: String
    let participants: Int
    let price: Float
    let link: String
    let key: String
}




