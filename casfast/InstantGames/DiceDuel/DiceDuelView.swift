import SwiftUI

struct DiceDuelView: View {
    @StateObject var viewModel =  DiceDuelViewModel()
    @State  var level = UserDefaultsManager.shared.currentLevel
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedBet: BetSide? = nil
    @State private var isGameActive = false
    @State private var playerRoll = 1
    @State private var houseRoll = 1
    @State private var showingAlert = false
    
    enum BetSide {
        case player, house
    }
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    Color.black.ignoresSafeArea()
                        .overlay {
                            Image("bgdice")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .ignoresSafeArea()
                                .opacity(0.5)
                        }
                    
                    ZStack {
                        Color(red: 88/255, green: 0/255, blue: 96/255)
                            .frame(height: UIScreen.main.bounds.width > 1000 ? 110 : 90)
                    }
                }
                
                ZStack {
                    ZStack(alignment: .top) {
                        Color(red: 88/255, green: 0/255, blue: 96/255).opacity(0.8)
                            .frame(height: 80)
                        
                        Color(red: 255/255, green: 0/255, blue: 153/255)
                            .frame(height: 1)
                    }
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
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
                                        
                                        Text("\(viewModel.coin)")
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
                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 0/255, blue: 0/255),
                                                      Color(red: 0/255, green: 102/255, blue: 255/255)], startPoint: .leading, endPoint: .trailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 176/255, green: 38/255, blue: 255/255).opacity(0.4))
                                .overlay {
                                    Text("DICE DUEL")
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
                
                HStack(alignment: .top) {
                    Button(action: {
                        NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                        presentationMode.wrappedValue.dismiss()
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
                                                .frame(width: 14, height: 14)
                                            
                                            Text("Back to Lobby")
                                                .font(.custom("PaytoneOne-Regular", size: 11))
                                                .foregroundStyle(.white)
                                                .shadow(radius: 3)
                                        }
                                    }
                            }
                            .frame(width: 122, height: 40)
                            .cornerRadius(20)
                    }
                    
                    ScrollView(showsIndicators: false) {
                        Rectangle()
                            .fill(Color.black.opacity(0.8))
                            .overlay {
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(Color(red: 255/255, green: 0/255, blue: 153/255) , lineWidth: 3)
                                    .overlay {
                                        HStack(spacing: 25) {
                                            VStack {
                                                VStack(spacing: 5) {
                                                    Text("Player")
                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                        .foregroundStyle(.white)
                                                    
                                                    Image("dice1")
                                                        .resizable()
                                                        .frame(width: 62, height: 62)
                                                    
                                                    Text("\(playerRoll)")
                                                        .font(.custom("PaytoneOne-Regular", size: 16))
                                                        .foregroundStyle(.white)
                                                }
                                                
                                                Button(action: {
                                                    selectedBet = .player
                                                }) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [
                                                            selectedBet == .player ? Color.green : Color(red: 255/255, green: 0/255, blue: 0/255),
                                                            selectedBet == .player ? Color(red: 0/255, green: 0.5, blue: 0/255) : Color(red: 25/255, green: 176/255, blue: 217/255)
                                                        ], startPoint: .leading, endPoint: .trailing))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(selectedBet == .player ? Color.yellow : Color(red: 176/255, green: 38/255, blue: 255/255).opacity(0.4), lineWidth: 2)
                                                                .overlay {
                                                                    Text("Bet on Player")
                                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                                        .foregroundStyle(.white)
                                                                        .shadow(radius: 2)
                                                                }
                                                        }
                                                        .frame(width: 180, height: 38)
                                                        .cornerRadius(12)
                                                }
                                            }
                                            
                                            VStack {
                                                VStack(spacing: 5) {
                                                    Text("Home")
                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                        .foregroundStyle(.white)
                                                    
                                                    Image("dice2")
                                                        .resizable()
                                                        .frame(width: 62, height: 62)
                                                    
                                                    Text("\(houseRoll)")
                                                        .font(.custom("PaytoneOne-Regular", size: 16))
                                                        .foregroundStyle(.white)
                                                }
                                                
                                                Button(action: {
                                                    selectedBet = .house
                                                }) {
                                                    Rectangle()
                                                        .fill(LinearGradient(colors: [
                                                            selectedBet == .house ? Color.green : Color(red: 25/255, green: 176/255, blue: 217/255),
                                                            selectedBet == .house ? Color(red: 0/255, green: 0.5, blue: 0/255) : Color(red: 255/255, green: 0/255, blue: 0/255)
                                                        ], startPoint: .leading, endPoint: .trailing))
                                                        .overlay {
                                                            RoundedRectangle(cornerRadius: 12)
                                                                .stroke(selectedBet == .house ? Color.yellow : Color(red: 176/255, green: 38/255, blue: 255/255).opacity(0.4), lineWidth: 2)
                                                                .overlay {
                                                                    Text("Bet on House")
                                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                                        .foregroundStyle(.white)
                                                                        .shadow(radius: 2)
                                                                }
                                                        }
                                                        .frame(width: 180, height: 38)
                                                        .cornerRadius(12)
                                                }
                                            }
                                        }
                                    }
                            }
                            .frame(height: 200)
                            .cornerRadius(14)
                    }
                    
                    Button(action: {
                        NotificationCenter.default.post(name: Notification.Name("RefreshData"), object: nil)
                        presentationMode.wrappedValue.dismiss()
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
                    .disabled(true)
                    .hidden()
                }
                .padding(.horizontal)
                .offset(y: 10)
                
                HStack {
                    Button(action: {
                        if selectedBet == nil {
                             showingAlert = true
                         } else if !isGameActive {
                             guard viewModel.bet <= viewModel.coin else { return }
                             viewModel.coin -= viewModel.bet
                             UserDefaultsManager.shared.coins = viewModel.coin
                             
                             playerRoll = Int.random(in: 1...6)
                             houseRoll = Int.random(in: 1...6)
                             
                             if playerRoll > houseRoll && selectedBet == .player ||
                                houseRoll > playerRoll && selectedBet == .house {
                                 viewModel.win = viewModel.bet * 2
                             } else {
                                 viewModel.win = 0
                             }
                             
                             isGameActive = true
                             selectedBet = nil
                         } else if isGameActive && viewModel.win == 0 {
                             isGameActive = false
                             playerRoll = 1
                             houseRoll = 1
                             viewModel.win = 0
                         }
                    }) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 197/255, green: 54/255, blue: 226/255)], startPoint: .leading, endPoint: .trailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white)
                                    .overlay {
                                        HStack {
                                            Text(selectedBet == nil ? "CHOOSE" : "LAUNCH")
                                                .font(.custom("PaytoneOne-Regular", size: 18))
                                                .foregroundStyle(.white)
                                                .shadow(radius: 3)
                                        }
                                    }
                            }
                            .frame(width: 112, height: 40)
                            .cornerRadius(8)
                            .shadow(color: Color(red: 197/255, green: 54/255, blue: 226/255), radius: 5)
                    }
                    .alert("Choose your dice", isPresented: $showingAlert) {
                        Button("OK") { }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.bet = viewModel.coin
                    }) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 254/255, green: 128/255, blue: 1/255)], startPoint: .leading, endPoint: .trailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white)
                                    .overlay {
                                        HStack {
                                            Text("MAX BET")
                                                .font(.custom("PaytoneOne-Regular", size: 18))
                                                .foregroundStyle(.white)
                                                .shadow(radius: 3)
                                        }
                                    }
                            }
                            .frame(width: 112, height: 40)
                            .cornerRadius(8)
                            .shadow(color: Color(red: 254/255, green: 128/255, blue: 1/255), radius: 5)
                    }
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(.black.opacity(0.5))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white)
                                .overlay {
                                    VStack(spacing: 0) {
                                        Text("WIN")
                                            .font(.custom("PaytoneOne-Regular", size: 16))
                                            .foregroundStyle(.yellow)
                                            .shadow(radius: 3)
                                        
                                        HStack {
                                            Text("\(viewModel.win)")
                                                .font(.custom("PaytoneOne-Regular", size: 16))
                                                .foregroundStyle(.white)
                                                .shadow(radius: 3)
                                            
                                            Image("coin")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                }
                        }
                        .frame(width: 132, height: 50)
                        .cornerRadius(8)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            if viewModel.bet >= 20 {
                                viewModel.bet -= 10
                            }
                        }) {
                            Rectangle()
                                .fill(Color(red: 226/255, green: 53/255, blue: 57/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.white)
                                        .overlay {
                                            Text("-")
                                                .font(.custom("PaytoneOne-Regular", size: 29))
                                                .foregroundStyle(.white)
                                                .shadow(radius: 3)
                                                .offset(y: -4)
                                        }
                                }
                                .frame(width: 52, height: 30)
                                .cornerRadius(8)
                                .shadow(color: Color(red: 226/255, green: 53/255, blue: 57/255), radius: 5)
                        }
                        
                        Rectangle()
                            .fill(.black.opacity(0.5))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white)
                                    .overlay {
                                        VStack(spacing: 0) {
                                            Text("BET")
                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                .foregroundStyle(.yellow)
                                                .shadow(radius: 3)
                                            
                                            HStack {
                                                Text("\(viewModel.bet)")
                                                    .font(.custom("PaytoneOne-Regular", size: 14))
                                                    .foregroundStyle(.white)
                                                    .shadow(radius: 3)
                                                
                                                Image("coin")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 20, height: 20)
                                            }
                                        }
                                    }
                            }
                            .frame(width: 112, height: 50)
                            .cornerRadius(8)
                        
                        
                        Button(action: {
                            if (viewModel.bet + 10) <= viewModel.coin {
                                viewModel.bet += 10
                            }
                        }) {
                            Rectangle()
                                .fill(Color(red: 53/255, green: 226/255, blue: 54/255))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.white)
                                        .overlay {
                                            Text("+")
                                                .font(.custom("PaytoneOne-Regular", size: 29))
                                                .foregroundStyle(.white)
                                                .shadow(radius: 3)
                                                .offset(y: -4)
                                        }
                                }
                                .frame(width: 52, height: 30)
                                .cornerRadius(8)
                                .shadow(color: Color(red: 53/255, green: 226/255, blue: 54/255), radius: 5)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            if viewModel.win > 0 {
                Color.black.ignoresSafeArea().opacity(0.5)
                
                Image("coinsImg")
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 25) {
                    Image("windice")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 190)
                    
                    Rectangle()
                        .fill(.black.opacity(0.5))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white)
                                .overlay {
                                    VStack(spacing: 0) {
                                        Text("WIN")
                                            .font(.custom("PaytoneOne-Regular", size: 16))
                                            .foregroundStyle(.green)
                                            .shadow(radius: 3)
                                        
                                        HStack {
                                            Text("\(viewModel.win)")
                                                .font(.custom("PaytoneOne-Regular", size: 16))
                                                .foregroundStyle(.green)
                                                .shadow(radius: 3)
                                            
                                            Image("coin")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 20, height: 20)
                                        }
                                    }
                                }
                        }
                        .frame(width: 132, height: 50)
                        .cornerRadius(8)
                    
                    Button(action: {
                        viewModel.win = 0
                    }) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 197/255, green: 54/255, blue: 226/255)], startPoint: .leading, endPoint: .trailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white)
                                    .overlay {
                                        HStack {
                                            Text("CLAIM")
                                                .font(.custom("PaytoneOne-Regular", size: 14))
                                                .foregroundStyle(.white)
                                                .shadow(radius: 3)
                                        }
                                    }
                            }
                            .frame(width: 172, height: 30)
                            .cornerRadius(8)
                    }
                }
            }
        }
    }
}

#Preview {
    DiceDuelView()
}

