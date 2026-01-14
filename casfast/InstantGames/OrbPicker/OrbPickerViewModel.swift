import SwiftUI

class OrbPickerViewModel: ObservableObject {
    let contact = OrbPickerModel()
    @Published var coin =   UserDefaultsManager.shared.coins
    @Published var bet = 10
    @Published var win = 0
}
