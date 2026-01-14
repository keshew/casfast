import SwiftUI

class SugarySpireViewModel: ObservableObject {
    let contact = SugarySpireModel()
    @Published var slots: [[String]] = []
    @Published var coin =   UserDefaultsManager.shared.coins
    @Published var bet = 10
    let allFruits = ["spr1", "spr2", "spr3","spr4", "spr5", "spr6"]
    @Published var winningPositions: [(row: Int, col: Int)] = []
    @Published var isSpinning = false
    @Published var isStopSpininng = false
    @Published var isWin = false
    @Published var win = 0
    var spinningTimer: Timer?
    @ObservedObject private var soundManager = SoundManager.shared
    
    init() {
        resetSlots()
    }
    
    @Published var betString: String = "5" {
        didSet {
            if let newBet = Int(betString), newBet > 0 {
                bet = newBet
            }
        }
    }
    let symbolArray = [
        Symbol(image: "spr1", value: "200"),
        Symbol(image: "spr2", value: "100"),
        Symbol(image: "spr3", value: "75"),
        Symbol(image: "spr4", value: "50"),
        Symbol(image: "spr5", value: "25"),
        Symbol(image: "spr6", value: "10")
    ]
    
    func resetSlots() {
        slots = (0..<3).map { _ in
            (0..<6).map { _ in
                allFruits.randomElement()!
            }
        }
    }
    
    func spin() {
        UserDefaultsManager.shared.removeCoins(bet)
        coin =  UserDefaultsManager.shared.coins
        UserDefaultsManager.shared.playSlotGame()
        isSpinning = true
        soundManager.playSlot1()
        spinningTimer?.invalidate()
        winningPositions.removeAll()
        win = 0
        let columns = 6
        for col in 0..<columns {
            let delay = Double(col) * 0.4
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                var spinCount = 0
                let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                    for row in 0..<3 {
                        withAnimation(.spring(response: 0.1, dampingFraction: 1.5, blendDuration: 0)) {
                            self.slots[row][col] = self.allFruits.randomElement()!
                        }
                    }
                    spinCount += 1
                    if spinCount > 12 + col * 4 {
                        timer.invalidate()
                        if col == columns - 1 {
                            self.isSpinning = false
                            self.soundManager.stopSlot()
                            self.checkWin()
                        }
                    }
                }
                RunLoop.current.add(timer, forMode: .common)
            }
        }
    }
    
    func checkWin() {
        winningPositions = []
        var totalWin = 0
        var maxMultiplier = 0
        let minCounts = [
            "spr1": 6,
            "spr2": 6,
            "spr3": 6,
            "spr4": 6,
            "spr5": 6,
            "spr6": 6
        ]
        let multipliers = [
            "spr1": 200,
            "spr2": 100,
            "spr3": 75,
            "spr4": 50,
            "spr5": 25,
            "spr6": 10
        ]
        
        checkRows(minCounts: minCounts, multipliers: multipliers, totalWin: &totalWin, maxMultiplier: &maxMultiplier)
        
        checkMainDiagonal(minCounts: minCounts, multipliers: multipliers, totalWin: &totalWin, maxMultiplier: &maxMultiplier)
        
        checkAntiDiagonal(minCounts: minCounts, multipliers: multipliers, totalWin: &totalWin, maxMultiplier: &maxMultiplier)
        
        if totalWin != 0 {
            win = totalWin
            isWin = true
            UserDefaultsManager.shared.addCoins(totalWin)
            coin = UserDefaultsManager.shared.coins
        }
    }

    private func checkMainDiagonal(minCounts: [String: Int], multipliers: [String: Int], totalWin: inout Int, maxMultiplier: inout Int) {
        let diagonal = [slots[0][0], slots[1][1], slots[2][2]]
        checkLine(diagonal: diagonal, positions: [(0,0), (1,1), (2,2)], minCounts: minCounts, multipliers: multipliers, totalWin: &totalWin, maxMultiplier: &maxMultiplier)
    }

    private func checkAntiDiagonal(minCounts: [String: Int], multipliers: [String: Int], totalWin: inout Int, maxMultiplier: inout Int) {
        let diagonal = [slots[0][2], slots[1][1], slots[2][0]]
        checkLine(diagonal: diagonal, positions: [(0,2), (1,1), (2,0)], minCounts: minCounts, multipliers: multipliers, totalWin: &totalWin, maxMultiplier: &maxMultiplier)
    }

    private func checkLine(diagonal: [String], positions: [(row: Int, col: Int)], minCounts: [String: Int], multipliers: [String: Int], totalWin: inout Int, maxMultiplier: inout Int) {
        var currentSymbol = diagonal[0]
        var count = 1
        
        for i in 1..<diagonal.count {
            if diagonal[i] == currentSymbol {
                count += 1
            } else {
                if let minCount = minCounts[currentSymbol], count >= minCount {
                    let multiplierValue = multipliers[currentSymbol] ?? 0
                    totalWin += multiplierValue
                    if multiplierValue > maxMultiplier {
                        maxMultiplier = multiplierValue
                    }
                    let startIndex = i - count
                    for j in startIndex..<i {
                        winningPositions.append(positions[j])
                    }
                }
                currentSymbol = diagonal[i]
                count = 1
            }
        }
        
        if let minCount = minCounts[currentSymbol], count >= minCount {
            let multiplierValue = multipliers[currentSymbol] ?? 0
            totalWin += multiplierValue
            if multiplierValue > maxMultiplier {
                maxMultiplier = multiplierValue
            }
            let startIndex = diagonal.count - count
            for j in startIndex..<diagonal.count {
                winningPositions.append(positions[j])
            }
        }
    }

    private func checkRows(minCounts: [String: Int], multipliers: [String: Int], totalWin: inout Int, maxMultiplier: inout Int) {
        for row in 0..<3 {
            let rowContent = slots[row]
            var currentSymbol = rowContent[0]
            var count = 1
            
            for col in 1..<rowContent.count {
                if rowContent[col] == currentSymbol {
                    count += 1
                } else {
                    if let minCount = minCounts[currentSymbol], count >= minCount {
                        let multiplierValue = multipliers[currentSymbol] ?? 0
                        totalWin += multiplierValue
                        if multiplierValue > maxMultiplier {
                            maxMultiplier = multiplierValue
                        }
                        let startCol = col - count
                        for c in startCol..<col {
                            winningPositions.append((row: row, col: c))
                        }
                    }
                    currentSymbol = rowContent[col]
                    count = 1
                }
            }
            
            if let minCount = minCounts[currentSymbol], count >= minCount {
                let multiplierValue = multipliers[currentSymbol] ?? 0
                totalWin += multiplierValue
                if multiplierValue > maxMultiplier {
                    maxMultiplier = multiplierValue
                }
                let startCol = rowContent.count - count
                for c in startCol..<rowContent.count {
                    winningPositions.append((row: row, col: c))
                }
            }
        }
    }
}


