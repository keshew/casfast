import SwiftUI

struct AchievemenetsView: View {
    @StateObject var achievemenetsModel =  AchievemenetsViewModel()
    var achiev = UserDefaultsManager.shared.achievements
    @State  var coin = UserDefaultsManager.shared.coins
    @State  var level = UserDefaultsManager.shared.currentLevel
    @Environment(\.presentationMode) var presentationMode
    
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
                                    Text("ACHIEVEMENTS")
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
                            .padding(.horizontal)
                        
                        VStack(spacing: 20) {
                            LazyVGrid(columns: [GridItem(.flexible(minimum: 230, maximum: 280)), GridItem(.flexible(minimum: 230, maximum: 280)),
                                                GridItem(.flexible(minimum: 230, maximum: 280))]) {
                                ForEach(achiev, id: \.id) { item in
                                    Rectangle()
                                        .fill(.black.opacity(0.7))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color(red: 176/255, green: 38/255, blue: 255/255).opacity(0.7), lineWidth: 2)
                                                .overlay {
                                                    VStack(spacing: 10) {
                                                        Image(systemName: item.isDone ? "checkmark" : "lock")
                                                            .resizable()
                                                            .foregroundStyle(.white)
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 44, height: 44)
                                                        
                                                        Text(item.name)
                                                            .font(.custom("PaytoneOne-Regular", size: 18))
                                                            .foregroundStyle(Color.white)
                                                        
                                                        Text(item.desc)
                                                            .font(.custom("PaytoneOne-Regular", size: 12))
                                                            .foregroundStyle(.white.opacity(0.4))
                                                            .multilineTextAlignment(.center)
                                                    }
                                                }
                                        }
                                        .frame(width: 240, height: 145)
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
    AchievemenetsView()
}

