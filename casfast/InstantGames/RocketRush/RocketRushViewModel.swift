import SwiftUI

class RocketRushViewModel: ObservableObject {
    let contact = RocketRushModel()
    @Published var coin: Int = UserDefaultsManager.shared.coins
     @Published var bet: Int = 20
     @Published var win: Int = 0
    @Published var multiplierTextColor: Color = Color(red: 141/255, green: 1/255, blue: 198/255)
}
