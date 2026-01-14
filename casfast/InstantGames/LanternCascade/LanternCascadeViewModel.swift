import SwiftUI

class LanternCascadeViewModel: ObservableObject {
    let contact = LanternCascadeModel()
    @Published var coin =   UserDefaultsManager.shared.coins
    @Published var bet = 10
    @Published var win = 0
    
    @Published var selectedIndex: Int? = nil
    @Published var targetIndex: Int = Int.random(in: 0..<5)
    
    func randomizeTarget() {
        targetIndex = Int.random(in: 0..<5)
    }
    
    func launch() {
        guard let selectedIndex else { return }
        
        if selectedIndex == targetIndex {
            win = bet * 2
            coin += win
        } else {
            coin -= bet
        }
        
        randomizeTarget()
        self.selectedIndex = nil
    }
}
