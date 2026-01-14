import SwiftUI

struct Achiev: Identifiable, Codable {
    var id = UUID()
    var name: String
    var desc: String
    var isDone: Bool = false
}

class UserDefaultsManager: ObservableObject {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    private let achievementsKey = "achievements"
    private let missionsKey = "missions"
    
    // MARK: - Coins
    var coins: Int {
        get { defaults.integer(forKey: "coins") }
        set { defaults.set(newValue, forKey: "coins"); objectWillChange.send() }
    }
    
    func addCoins(_ amount: Int) {
        coins += amount
    }
    
    func removeCoins(_ amount: Int) {
        coins = max(coins - amount, 0)
    }
    
    @Published var firstSpinCompleted = false {
        didSet {
            defaults.set(firstSpinCompleted, forKey: "firstSpinCompleted")
            objectWillChange.send()
            checkAchievementsCompletion()
        }
    }
    
    @Published var dailyRewards: [DailyModels] = [] {
        didSet {
            saveDailyRewards()
        }
    }

    private func loadDefaultDailyRewards() {
        dailyRewards = [DailyModels(day: 1, reward: 500),
                        DailyModels(day: 2, reward: 750),
                        DailyModels(day: 3, reward: 1000),
                        DailyModels(day: 4, reward: 1500),
                        DailyModels(day: 5, reward: 2500),
                        DailyModels(day: 6, reward: 3000),
                        DailyModels(day: 7, reward: 3500),
                        DailyModels(day: 8, reward: 4000),
                        DailyModels(day: 9, reward: 4500),
                        DailyModels(day: 10, reward: 5000),
                        DailyModels(day: 11, reward: 5500),
                        DailyModels(day: 12, reward: 6000),
                        DailyModels(day: 13, reward: 6500),
                        DailyModels(day: 14, reward: 7000),
                        DailyModels(day: 15, reward: 7500),
                        DailyModels(day: 16, reward: 8000)]
        updateDailyRewardsStatus()
    }

    private func saveDailyRewards() {
        if let data = try? JSONEncoder().encode(dailyRewards) {
            defaults.set(data, forKey: "dailyRewards")
        }
    }

    private func loadDailyRewards() {
        if let data = defaults.data(forKey: "dailyRewards"),
           let decoded = try? JSONDecoder().decode([DailyModels].self, from: data) {
            dailyRewards = decoded
            updateDailyRewardsStatus()
        } else {
            loadDefaultDailyRewards()
        }
    }

    private func updateDailyRewardsStatus() {
        let lastClaimDate = defaults.object(forKey: "lastDailyClaimDate") as? Date ?? Date.distantPast
        let calendar = Calendar.current
        
        if calendar.isDateInToday(lastClaimDate) == false {
            let currentStreak = getCurrentStreak()
            
            for i in 0..<dailyRewards.count {
                let day = dailyRewards[i].day
                if day == currentStreak + 1 && !dailyRewards[i].isGot {
                    dailyRewards[i].isCanGet = true
                } else {
                    dailyRewards[i].isCanGet = false
                }
            }
        }
    }

    func claimDailyReward() -> Bool {
        guard let todayReward = dailyRewards.first(where: { $0.isCanGet && !$0.isGot }) else {
            return false
        }
        
        addCoins(todayReward.reward)
        let index = dailyRewards.firstIndex(where: { $0.id == todayReward.id })!
        dailyRewards[index].isGot = true
        dailyRewards[index].isCanGet = false
        
        defaults.set(Date(), forKey: "lastDailyClaimDate")
        
        print("🎁 Daily reward Day \(todayReward.day): +\(todayReward.reward) coins!")
        return true
    }

    private func getCurrentStreak() -> Int {
        let claimedDays = dailyRewards.filter { $0.isGot }.map { $0.day }
        return claimedDays.count
    }

    func resetDailyRewards() {
        defaults.removeObject(forKey: "dailyRewards")
        defaults.removeObject(forKey: "lastDailyClaimDate")
        loadDailyRewards()
    }

    
    @Published var consecutiveWins = 0 {
        didSet { defaults.set(consecutiveWins, forKey: "consecutiveWins"); objectWillChange.send() }
    }
    
    @Published var singleSpinMaxWin = 0 {
        didSet { defaults.set(singleSpinMaxWin, forKey: "singleSpinMaxWin"); objectWillChange.send() }
    }
    
    @Published var slotsPlayed = 0 {
        didSet { defaults.set(slotsPlayed, forKey: "slotsPlayed"); objectWillChange.send() }
    }
    
    @Published var maxBetCount = 0 {
        didSet { defaults.set(maxBetCount, forKey: "maxBetCount"); objectWillChange.send() }
    }
    
    @Published var totalSpins = 0 {
        didSet {
            defaults.set(totalSpins, forKey: "totalSpins")
            objectWillChange.send()
            updateMissionProgress()
        }
    }
    
    @Published var currentXP: Int = 0 {
        didSet {
            defaults.set(currentXP, forKey: "currentXP")
            checkLevelUp()
            objectWillChange.send()
        }
    }
    
    @Published var profileImageName: String = "profileImg1" {
        didSet { defaults.set(profileImageName, forKey: "profileImageName"); objectWillChange.send() }
    }
    
    @Published var currentLevel: Int = 1 {
        didSet {
            defaults.set(currentLevel, forKey: "currentLevel")
            objectWillChange.send()
            updateMissionProgress()
        }
    }
    
    @Published var minesRevealed: Int = 0 {
        didSet { defaults.set(minesRevealed, forKey: "minesRevealed"); objectWillChange.send() }
    }
    
    @Published var coinFlipsWon: Int = 0 {
        didSet { defaults.set(coinFlipsWon, forKey: "coinFlipsWon"); objectWillChange.send() }
    }
    
    @Published var crashCashouts5x: Int = 0 {
        didSet { defaults.set(crashCashouts5x, forKey: "crashCashouts5x"); objectWillChange.send() }
    }
    
    @Published var totalGamesPlayed: Int = 0 {
        didSet { defaults.set(totalGamesPlayed, forKey: "totalGamesPlayed"); objectWillChange.send() }
    }
    
    @Published var maxBetAmount: Int = 0 {
        didSet {
            defaults.set(maxBetAmount, forKey: "maxBetAmount")
            objectWillChange.send()
            checkAchievementsCompletion()
        }
    }
    
    @Published var maxMultiplierWon: Double = 0 {
        didSet { defaults.set(maxMultiplierWon, forKey: "maxMultiplierWon"); objectWillChange.send() }
    }
    
    @Published var fruitSlotsWins: Int = 0 {
        didSet { defaults.set(fruitSlotsWins, forKey: "fruitSlotsWins"); objectWillChange.send() }
    }
    
    @Published var classicSlotsWins: Int = 0 {
        didSet { defaults.set(classicSlotsWins, forKey: "classicSlotsWins"); objectWillChange.send() }
    }
    
    @Published var goldSlotsWins: Int = 0 {
        didSet { defaults.set(goldSlotsWins, forKey: "goldSlotsWins"); objectWillChange.send() }
    }
    
    @Published var totalWins: Int = 0 {
        didSet {
            defaults.set(totalWins, forKey: "totalWins")
            objectWillChange.send()
            updateMissionProgress()
            checkAchievementsCompletion()
        }
    }
    
    @Published var totalCoinsWon: Int = 0 {
        didSet { defaults.set(totalCoinsWon, forKey: "totalCoinsWon"); objectWillChange.send() }
    }
    
    @Published var achievements: [Achiev] = [] {
        didSet {
            saveAchievements()
            checkAchievementsCompletion()
        }
    }
    
    @Published var missions: [Missions] = [] {
        didSet {
            saveMissions()
            checkMissionsCompletion()
        }
    }
    
    @Published var achievementsData: [String: Int] = [:] {
        didSet {
            defaults.set(try? JSONEncoder().encode(achievementsData), forKey: "achievementsData")
        }
    }
    
    private func loadDefaultAchievements() {
        achievements = [
            Achiev(name: "Rocket Ace", desc: "Cash out at 25x multiplier in Rocket Rush", isDone: firstSpinCompleted),
            Achiev(name: "Jungle Explorer", desc: "Win 50 times on Jungle Jackpots", isDone: totalWins >= 100),
            Achiev(name: "Crystal Collector", desc: "Win 100 times on Crystal Cascade", isDone: maxBetAmount >= 10000),
            Achiev(name: "Space Pioneer", desc: "Play Starliner Spin 200 times", isDone: singleSpinMaxWin >= 5000),
            Achiev(name: "Dice Master", desc: "Win 100 Dice Duels in a row", isDone: maxBetAmount >= 10000),
            Achiev(name: "Lantern Legend", desc: "Release 200 lanterns", isDone: singleSpinMaxWin >= 5000)
        ]
    }
    
    private func loadDefaultMissions() {
        missions = [
            Missions(name: "Spin Master", desc: "Complete 50 spins", reward: 5000, goal: 50, currentStep: totalSpins),
            Missions(name: "Slot Fanatic", desc: "Play slots 100 times", reward: 2000, goal: 100, currentStep: slotsPlayed),
            Missions(name: "Slot Champion", desc: "Play slots 100 times", reward: 2000, goal: 200, currentStep: slotsPlayed)
        ]
    }

    
    private func saveAchievements() {
        if let data = try? JSONEncoder().encode(achievements) {
            defaults.set(data, forKey: "achievementsList")
        }
    }
    
    private func saveMissions() {
        if let data = try? JSONEncoder().encode(missions) {
            defaults.set(data, forKey: "missionsList")
        }
    }
    
    private func loadAchievements() {
        if let data = defaults.data(forKey: "achievementsList"),
           let decoded = try? JSONDecoder().decode([Achiev].self, from: data) {
            achievements = decoded
        } else {
            loadDefaultAchievements()
        }
    }
    
    private func loadMissions() {
        if let data = defaults.data(forKey: "missionsList"),
           let decoded = try? JSONDecoder().decode([Missions].self, from: data) {
            missions = decoded
        } else {
            loadDefaultMissions()
        }
    }
    
    private func checkMissionsCompletion() {
        for i in 0..<missions.count {
            let mission = missions[i]
            if mission.isDone && !defaults.bool(forKey: "mission_\(mission.id.uuidString)_claimed") {
                addCoins(mission.reward)
                defaults.set(true, forKey: "mission_\(mission.id.uuidString)_claimed")
                print("🎉 Mission '\(mission.name)' completed! +\(mission.reward) coins")
                objectWillChange.send()
            }
        }
    }
    
    func updateMissionProgress() {
        for i in 0..<missions.count {
            let mission = missions[i]
            
            switch mission.name {
            case "Spin Master":
                missions[i].currentStep = totalSpins
            case "Rocket Rider":
                missions[i].currentStep = totalWins
            case "High Roller":
                missions[i].currentStep = currentLevel
            case "Slot Fanatic":
                missions[i].currentStep = slotsPlayed
            default:
                missions[i].currentStep = 0
            }
        }
        objectWillChange.send()
    }
    
    private func calculateDifferentGamesPlayed() -> Int {
        var games: Set<String> = []
        if slotsPlayed > 0 { games.insert("slots") }
        if minesRevealed > 0 { games.insert("mines") }
        if coinFlipsWon > 0 { games.insert("coinflip") }
        if crashCashouts5x > 0 { games.insert("crash") }
        return min(games.count, 3) // max 3 для миссии
    }
    
    private func checkAchievementsCompletion() {
        if let firstSpin = achievements.first(where: { $0.name == "First Spin" }),
           firstSpinCompleted && !firstSpin.isDone {
            if let index = achievements.firstIndex(where: { $0.id == firstSpin.id }) {
                achievements[index].isDone = true
                addCoins(100)
                print("🎉 Achievement 'First Spin' unlocked! +100 coins")
            }
        }
        
        if let lucky = achievements.first(where: { $0.name == "Lucky Winner" }),
           totalWins >= 10 && !lucky.isDone {
            if let index = achievements.firstIndex(where: { $0.id == lucky.id }) {
                achievements[index].isDone = true
                addCoins(500)
                print("🎉 Achievement 'Lucky Winner' unlocked! +500 coins")
            }
        }
        
        if let highRoller = achievements.first(where: { $0.name == "High Roller" }),
           maxBetAmount >= 1000 && !highRoller.isDone {
            if let index = achievements.firstIndex(where: { $0.id == highRoller.id }) {
                achievements[index].isDone = true
                addCoins(750)
                print("🎉 Achievement 'High Roller' unlocked! +750 coins")
            }
        }
    }
    
    func addXP(_ amount: Int) {
        currentXP += amount
    }
    
    func playGame() {
        totalGamesPlayed += 1
        addXP(10)
    }
    
    private func checkLevelUp() {
        while currentXP >= currentLevel * 1000 {
            currentLevel += 1
            print("🎉 Level Up! Now level \(currentLevel)")
        }
    }
    
    var xpProgress: Double {
        let xpForCurrentLevel = (currentLevel - 1) * 1000
        let xpNeededForNextLevel = currentLevel * 1000
        let progress = Double(currentXP - xpForCurrentLevel) / Double(xpNeededForNextLevel - xpForCurrentLevel)
        return min(progress, 1.0)
    }
    
    var xpToNextLevel: Int {
        currentLevel * 1000 - currentXP
    }
    
    func afterGamePlayed() {
        totalSpins += 1
        playGame()
        updateMissionProgress()
        checkAchievementsCompletion()
    }
    
    func completeFirstSpin() {
        if !firstSpinCompleted {
            firstSpinCompleted = true
        }
    }
    
    func addConsecutiveWin() {
        consecutiveWins += 1
    }
    
    func resetConsecutiveWins() {
        consecutiveWins = 0
    }
    
    func updateSingleSpinWin(_ amount: Int) {
        if amount > singleSpinMaxWin {
            singleSpinMaxWin = amount
        }
    }
    
    func playSlotGame() {
        slotsPlayed += 1
        afterGamePlayed()
    }
    
    func placeMaxBet() {
        maxBetCount += 1
        if coins >= 1000 {
            maxBetAmount = max(maxBetAmount, coins)
        }
    }
    
    func recordWin(_ winAmount: Int) {
        totalWins += 1
        totalCoinsWon += winAmount
        addCoins(winAmount)
    }
    
    func incrementAchievement(_ key: String, by amount: Int = 1) {
        achievementsData[key, default: 0] += amount
        objectWillChange.send()
    }
    
    func getAchievementProgress(_ key: String) -> Int {
        achievementsData[key, default: 0]
    }
    
    private init() {
        loadAllData()
        loadAchievementsData()
        loadAchievements()
        loadMissions()
        loadDailyRewards() 
    }
    
    private func loadAllData() {
        firstSpinCompleted = defaults.bool(forKey: "firstSpinCompleted")
        consecutiveWins = defaults.integer(forKey: "consecutiveWins")
        singleSpinMaxWin = defaults.integer(forKey: "singleSpinMaxWin")
        slotsPlayed = defaults.integer(forKey: "slotsPlayed")
        maxBetCount = defaults.integer(forKey: "maxBetCount")
        totalSpins = defaults.integer(forKey: "totalSpins")
        coins = defaults.integer(forKey: "coins")
        
        let savedLevel = defaults.integer(forKey: "currentLevel")
        currentLevel = savedLevel > 0 ? savedLevel : 1
        
        if let savedProfileImg = defaults.string(forKey: "profileImageName") {
            profileImageName = savedProfileImg
        }
        
        currentXP = defaults.integer(forKey: "currentXP")
        minesRevealed = defaults.integer(forKey: "minesRevealed")
        coinFlipsWon = defaults.integer(forKey: "coinFlipsWon")
        crashCashouts5x = defaults.integer(forKey: "crashCashouts5x")
        totalGamesPlayed = defaults.integer(forKey: "totalGamesPlayed")
        maxBetAmount = defaults.integer(forKey: "maxBetAmount")
        
        if let multiplier = defaults.value(forKey: "maxMultiplierWon") as? Double {
            maxMultiplierWon = multiplier
        }
        
        fruitSlotsWins = defaults.integer(forKey: "fruitSlotsWins")
        classicSlotsWins = defaults.integer(forKey: "classicSlotsWins")
        goldSlotsWins = defaults.integer(forKey: "goldSlotsWins")
        totalWins = defaults.integer(forKey: "totalWins")
        totalCoinsWon = defaults.integer(forKey: "totalCoinsWon")
        
        loadAchievementsData()
        updateMissionProgress()
    }
    
    func loadAchievementsData() {
        if let data = defaults.data(forKey: "achievementsData"),
           let decoded = try? JSONDecoder().decode([String: Int].self, from: data) {
            achievementsData = decoded
        }
    }
    
    func resetAllData() {
        coins = 0
        firstSpinCompleted = false
        consecutiveWins = 0
        singleSpinMaxWin = 0
        slotsPlayed = 0
        maxBetCount = 0
        totalSpins = 0
        currentXP = 0
        profileImageName = "profileImg1"
        currentLevel = 1
        minesRevealed = 0
        coinFlipsWon = 0
        crashCashouts5x = 0
        totalGamesPlayed = 0
        maxBetAmount = 0
        maxMultiplierWon = 0
        fruitSlotsWins = 0
        classicSlotsWins = 0
        goldSlotsWins = 0
        totalWins = 0
        totalCoinsWon = 0
        
        addCoins(5000)
        
        let keysToRemove = [
            "coins", "firstSpinCompleted", "consecutiveWins", "singleSpinMaxWin",
            "slotsPlayed", "maxBetCount", "totalSpins", "currentXP",
            "profileImageName", "currentLevel", "minesRevealed", "coinFlipsWon",
            "crashCashouts5x", "totalGamesPlayed", "maxBetAmount", "maxMultiplierWon",
            "fruitSlotsWins", "classicSlotsWins", "goldSlotsWins", "totalWins",
            "totalCoinsWon", "achievementsList", "missionsList", "achievementsData"
        ]
        
        for key in keysToRemove {
            defaults.removeObject(forKey: key)
        }
        
        achievements = []
        missions = []
    }
}
