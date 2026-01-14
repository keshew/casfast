import SwiftUI

class DiceDuelViewModel: ObservableObject {
    let contact = DiceDuelModel()
    @Published var coin =   UserDefaultsManager.shared.coins
    @Published var bet = 10
    @Published var win = 0
}
