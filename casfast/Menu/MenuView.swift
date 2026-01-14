import SwiftUI

struct MenuView: View {
    @StateObject var menuModel =  MenuViewModel()
    @State  var coin = UserDefaultsManager.shared.coins
    @State  var level = UserDefaultsManager.shared.currentLevel
    @State var slot1 = false
    @State var slot2 = false
    @State var slot3 = false
    @State var slot4 = false
    @State var slot5 = false
    @State var slot6 = false
    @State var ins1 = false
    @State var ins2 = false
    @State var ins3 = false
    @State var ins4 = false
    @State var daily = false
    @State var missions = false
    @State var achiev = false
    
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
                                    Text("MENU")
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
                    VStack(alignment: .leading, spacing: 25) {
                         Text("Slot Machines")
                            .font(.custom("PaytoneOne-Regular", size: 18))
                            .foregroundStyle(.white)
                            .shadow(radius: 3)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<6, id: \.self) { index in
                                    Button(action: {
                                        switch index {
                                        case 0: slot1 = true
                                        case 1: slot2 = true
                                        case 2: slot3 = true
                                        case 3: slot4 = true
                                        case 4: slot5 = true
                                        case 5: slot6 = true
                                        default: slot1 = true
                                        }
                                    }) {
                                        Image("slot\(index + 1)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 188, height: 188)
                                    }
                                }
                            }
                        }
                        
                        Text("Instant Fun")
                           .font(.custom("PaytoneOne-Regular", size: 18))
                           .foregroundStyle(.white)
                           .shadow(radius: 3)
                           .padding(.horizontal)
                       
                       ScrollView(.horizontal, showsIndicators: false) {
                           HStack(spacing: 15) {
                               ForEach(0..<4, id: \.self) { index in
                                   Button(action: {
                                       switch index {
                                       case 0: ins1 = true
                                       case 1: ins2 = true
                                       case 2: ins3 = true
                                       case 3: ins4 = true
                                       default: ins1 = true
                                       }
                                   }) {
                                       ZStack(alignment: .bottom) {
                                           Image("inst\(index + 1)")
                                               .resizable()
                                               .aspectRatio(contentMode: .fit)
                                               .frame(width: 188, height: 188)
                                           
                                          Image("pl\(index + 1)")
                                               .resizable()
                                               .aspectRatio(contentMode: .fit)
                                               .frame(width: 170, height: 30)
                                       }
                                   }
                               }
                           }
                           .padding(.horizontal)
                       }
                    }
                    
                        HStack(spacing: 20) {
                            Rectangle()
                                .fill(.black.opacity(0.5))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 255/255, green: 215/255, blue: 0/255), lineWidth: 3)
                                        .overlay {
                                            VStack {
                                                Image("dauly")
                                                    .resizable()
                                                    .frame(width: 42, height: 42)
                                                
                                                Text("Daily Rewards")
                                                    .font(.custom("PaytoneOne-Regular", size: 18))
                                                    .foregroundStyle(.white)
                                                    .shadow(radius: 3)
                                                
                                                Text("Claim your free coins!")
                                                    .font(.custom("PaytoneOne-Regular", size: 12))
                                                    .foregroundStyle(.white.opacity(0.5 ))
                                                    .shadow(radius: 3)
                                                
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [Color(red: 255/255, green: 179/255, blue: 71/255),
                                                                                  Color(red: 255/255, green: 127/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke( Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.4))
                                                            .overlay {
                                                                Button(action: {
                                                                    daily = true
                                                                }) {
                                                                    Text("CLAIM NOW")
                                                                        .font(.custom("PaytoneOne-Regular", size: 13))
                                                                        .foregroundStyle(.white)
                                                                        .shadow(radius: 3)
                                                                }
                                                            }
                                                    }
                                                    .frame(height: 30)
                                                    .cornerRadius(20)
                                                    .padding(.horizontal)
                                            }
                                        }
                                }
                                .frame(width: 230, height: 158)
                                .cornerRadius(16)
                            
                            Rectangle()
                                .fill(.black.opacity(0.5))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 1/255, green: 255/255, blue: 255/255), lineWidth: 3)
                                        .overlay {
                                            VStack {
                                                Image("miss")
                                                    .resizable()
                                                    .frame(width: 42, height: 42)
                                                
                                                Text("Missions")
                                                    .font(.custom("PaytoneOne-Regular", size: 18))
                                                    .foregroundStyle(.white)
                                                    .shadow(radius: 3)
                                                
                                                Text("Complete challenges")
                                                    .font(.custom("PaytoneOne-Regular", size: 12))
                                                    .foregroundStyle(.white.opacity(0.5 ))
                                                    .shadow(radius: 3)
                                                
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [Color(red: 4/255, green: 217/255, blue: 255/255),
                                                                                  Color(red: 3/255, green: 153/255, blue: 204/255)], startPoint: .leading, endPoint: .trailing))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke( Color(red: 0/255, green: 255/255, blue: 255/255).opacity(0.4))
                                                            .overlay {
                                                                Button(action: {
                                                                    missions = true
                                                                }) {
                                                                    Text("VIEW")
                                                                        .font(.custom("PaytoneOne-Regular", size: 13))
                                                                        .foregroundStyle(.white)
                                                                        .shadow(radius: 3)
                                                                }
                                                            }
                                                    }
                                                    .frame(height: 30)
                                                    .cornerRadius(20)
                                                    .padding(.horizontal)
                                            }
                                        }
                                }
                                .frame(width: 230, height: 158)
                                .cornerRadius(16)
                            
                            Rectangle()
                                .fill(.black.opacity(0.5))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(red: 176/255, green: 38/255, blue: 255/255), lineWidth: 3)
                                        .overlay {
                                            VStack {
                                                Image("achievme")
                                                    .resizable()
                                                    .frame(width: 42, height: 42)
                                                
                                                Text("Achievements")
                                                    .font(.custom("PaytoneOne-Regular", size: 18))
                                                    .foregroundStyle(.white)
                                                    .shadow(radius: 3)
                                                
                                                Text("Unlock badges")
                                                    .font(.custom("PaytoneOne-Regular", size: 12))
                                                    .foregroundStyle(.white.opacity(0.5 ))
                                                    .shadow(radius: 3)
                                                
                                                Rectangle()
                                                    .fill(LinearGradient(colors: [Color(red: 176/255, green: 38/255, blue: 255/255),
                                                                                  Color(red: 176/255, green: 38/255, blue: 255/255)], startPoint: .leading, endPoint: .trailing))
                                                    .overlay {
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(Color(red: 176/255, green: 38/255, blue: 255/255).opacity(0.4))
                                                            .overlay {
                                                                Button(action: {
                                                                    achiev = true
                                                                }) {
                                                                    Text("VIEW")
                                                                        .font(.custom("PaytoneOne-Regular", size: 13))
                                                                        .foregroundStyle(.white)
                                                                        .shadow(radius: 3)
                                                                }
                                                            }
                                                    }
                                                    .frame(height: 30)
                                                    .cornerRadius(20)
                                                    .padding(.horizontal)
                                            }
                                        }
                                }
                                .frame(width: 230, height: 158)
                                .cornerRadius(16)
                        }
                        .padding(.top)
                }
            }
        }
        .fullScreenCover(isPresented: $slot1, content: {
            NeonRoyaleView()
        })
        .fullScreenCover(isPresented: $slot2, content: {
            JungleJackpotView()
        })
        .fullScreenCover(isPresented: $slot3, content: {
            MoonlightManorView()
        })
        .fullScreenCover(isPresented: $slot4, content: {
            CrystalCascadeView()
        })
        .fullScreenCover(isPresented: $slot5, content: {
            StarlinerSpinView()
        })
        .fullScreenCover(isPresented: $slot6, content: {
            SugarySpireView()
        })
        
        .fullScreenCover(isPresented: $ins1, content: {
            RocketRushView()
        })
        .fullScreenCover(isPresented: $ins2, content: {
            OrbPickerView()
        })
        .fullScreenCover(isPresented: $ins3, content: {
            DiceDuelView()
        })
        .fullScreenCover(isPresented: $ins4, content: {
            LanternCascadeView()
        })
        
        .fullScreenCover(isPresented: $missions, content: {
            MisssionsView()
        })
        .fullScreenCover(isPresented: $daily, content: {
            DailyView()
        })
        .fullScreenCover(isPresented: $achiev, content: {
            AchievemenetsView()
        })
        
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("RefreshData"), object: nil, queue: .main) { _ in
                self.coin = UserDefaultsManager.shared.coins
            }
        }
    }
}

#Preview {
    MenuView()
}

