import SwiftUI

@main
struct casfastApp: App {
    
    init() {
        let stats = UserDefaultsManager.shared
        let key = "didAddInitialCoin2s"
        if !UserDefaults.standard.bool(forKey: key) {
            stats.addCoins(5000)
            UserDefaults.standard.set(true, forKey: "isMusicOn")
            UserDefaults.standard.set(true, forKey: key)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MenuView()
        }
    }
}
