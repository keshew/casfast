import SwiftUI

struct DailyModels: Identifiable, Codable {
    var id = UUID()
    var day: Int
    var reward: Int
    var isGot: Bool = false
    var isCanGet: Bool = false
}

struct DailyView: View {
    @StateObject var dailyModel =  DailyViewModel()
    @State  var coin = UserDefaultsManager.shared.coins
    @State  var level = UserDefaultsManager.shared.currentLevel
    @Environment(\.presentationMode) var presentationMode
    @State var showAlert = false
    @StateObject private var manager = UserDefaultsManager.shared
    
    
    var body: some View {
        ZStack {
            ZStack(alignment: .top) {
                Color.black.ignoresSafeArea()
                    .overlay {
                        Image("bgmain")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .ignoresSafeArea()
                            .opacity(0.5)
                    }
                
                ZStack {
                    Color(red: 24/255, green: 1/255, blue: 45/255)
                        .frame(height: UIScreen.main.bounds.width > 1000 ? 110 : 90)
                }
                .ignoresSafeArea()
            }
            
            VStack(spacing: 40) {
                HStack {
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 179/255, blue: 71/255),
                                                      Color(red: 255/255, green: 127/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 255/255, green: 215/255, blue: 0/255).opacity(0.4))
                                .overlay {
                                    HStack {
                                        Image("coin")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 24, height: 24)
                                        
                                        Text("\(coin)")
                                            .font(.custom("PaytoneOne-Regular", size: 18))
                                            .foregroundStyle(.white)
                                            .shadow(radius: 3)
                                    }
                                }
                        }
                        .frame(width: 122, height: 40)
                        .cornerRadius(20)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(red: 176/255, green: 38/255, blue: 255/255),
                                                      Color(red: 122/255, green: 27/255, blue: 217/255)], startPoint: .leading, endPoint: .trailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 176/255, green: 38/255, blue: 255/255).opacity(0.4))
                                .overlay {
                                    Text("DAILY REWARD")
                                        .font(.custom("PaytoneOne-Regular", size: 18))
                                        .foregroundStyle(.white)
                                        .shadow(radius: 3)
                                }
                        }
                        .frame(width: 250, height: 48)
                        .cornerRadius(16)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(LinearGradient(colors: [Color(red: 4/255, green: 217/255, blue: 255/255),
                                                      Color(red: 3/255, green: 153/255, blue: 204/255)], startPoint: .leading, endPoint: .trailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke( Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.4))
                                .overlay {
                                    HStack {
                                        Image("level")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 24, height: 24)
                                        
                                        Text("Level \(level)")
                                            .font(.custom("PaytoneOne-Regular", size: 18))
                                            .foregroundStyle(.white)
                                            .shadow(radius: 3)
                                    }
                                }
                        }
                        .frame(width: 122, height: 40)
                        .cornerRadius(20)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                            NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                        }) {
                            Rectangle()
                                .fill(LinearGradient(colors: [Color(red: 4/255, green: 217/255, blue: 255/255),
                                                              Color(red: 3/255, green: 153/255, blue: 204/255)], startPoint: .leading, endPoint: .trailing))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke( Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.4))
                                        .overlay {
                                            HStack {
                                                Image("backbt")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 20, height: 20)
                                                
                                                Text("Back to Lobby")
                                                    .font(.custom("PaytoneOne-Regular", size: 12))
                                                    .foregroundStyle(.white)
                                                    .shadow(radius: 3)
                                            }
                                        }
                                }
                                .frame(width: 142, height: 40)
                                .cornerRadius(20)
                        }
                        .padding(.horizontal)
                        
                        VStack(spacing: 20) {
                            LazyVGrid(columns: [GridItem(.flexible(minimum: 90, maximum: 100)),
                                                GridItem(.flexible(minimum: 90, maximum: 100)),
                                                GridItem(.flexible(minimum: 90, maximum: 100)),
                                                GridItem(.flexible(minimum: 90, maximum: 100)),
                                                GridItem(.flexible(minimum: 90, maximum: 100)),
                                                GridItem(.flexible(minimum: 90, maximum: 100)),
                                                GridItem(.flexible(minimum: 90, maximum: 100)),
                                                GridItem(.flexible(minimum: 90, maximum: 100))]) {
                                ForEach(0..<16, id: \.self) { index in
                                    Rectangle()
                                        .fill(.black.opacity(0.8))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(red: 255/255, green: 215/255, blue: 0/255))
                                                .overlay {
                                                    VStack {
                                                        Text("Day \(index + 1)")
                                                            .font(.custom("PaytoneOne-Regular", size: 12))
                                                            .foregroundStyle(.white.opacity(0.7))
                                                        
                                                        Image("unlo")
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 50, height: 40)
                                                        
                                                        Text("+\(manager.dailyRewards[index].reward)")
                                                            .font(.custom("PaytoneOne-Regular", size: 12))
                                                            .foregroundStyle(manager.dailyRewards[index].isCanGet ? .yellow : .white.opacity(0.7))
                                                        
                                                        Button(action: {
                                                            if manager.claimDailyReward() {
                                                                self.coin = UserDefaultsManager.shared.coins
                                                            } else {
                                                                showAlert = true
                                                            }
                                                        }) {
                                                            Rectangle()
                                                                .fill(LinearGradient(colors: manager.dailyRewards[index].isCanGet ? [Color(red: 255/255, green: 179/255, blue: 71/255),
                                                                                                                      Color(red: 255/255, green: 127/255, blue: 0/255)] : [Color(red: 101/255, green: 100/255, blue: 99/255),
                                                                                                                                                                           Color(red: 45/255, green: 45/255, blue: 45/255)], startPoint: .leading, endPoint: .trailing))
                                                                .overlay {
                                                                    RoundedRectangle(cornerRadius: 20)
                                                                        .stroke(manager.dailyRewards[index].isCanGet ? Color(red: 255/255, green: 215/255, blue: 0/255).opacity(0.4) : .gray)
                                                                        .overlay {
                                                                            Text("Claim")
                                                                                .font(.custom("PaytoneOne-Regular", size: 12))
                                                                                .foregroundStyle(.white)
                                                                                .shadow(radius: 3)
                                                                        }
                                                                }
                                                                .frame(width: 70, height: 20)
                                                                .cornerRadius(20)
                                                        }
                                                        .shadow(color: .yellow.opacity(0.6), radius: 4)
                                                        .disabled(!manager.dailyRewards.contains(where: { $0.isCanGet && !$0.isGot }))
                                                        .opacity(!manager.dailyRewards.contains(where: { $0.isCanGet && !$0.isGot }) ? 0.5 : 1)
                                                    }
                                                }
                                        }
                                        .frame(width: 90, height: 140)
                                        .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding([.horizontal])
                }
            }
        }
    }
}

#Preview {
    DailyView()
}

