import SwiftUI

struct Missions: Identifiable, Codable {
    var id = UUID()
    var name: String
    var desc: String
    var reward: Int
    var goal: Int
    var currentStep: Int
    
    var isDone: Bool {
        currentStep >= goal
    }
}

struct MisssionsView: View {
    @StateObject var misssionsModel =  MisssionsViewModel()
    var missions =  UserDefaultsManager.shared.missions
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
                                    Text("MISSIONS")
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
                        
                        VStack(spacing: 20) {
                            ForEach(missions, id: \.id) { item in
                                Rectangle()
                                    .fill(.black.opacity(0.5))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color(red: 1/255, green: 255/255, blue: 255/255), lineWidth: 2)
                                            .overlay {
                                                HStack {
                                                    VStack(alignment: .leading) {
                                                        HStack(alignment: .top) {
                                                            VStack(alignment: .leading, spacing: 10) {
                                                                VStack(alignment: .leading, spacing: 5) {
                                                                    Text(item.name)
                                                                        .font(.custom("PaytoneOne-Regular", size: 18))
                                                                        .foregroundStyle(.white)
                                                                    
                                                                    Text(item.desc)
                                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                                        .foregroundStyle(.white.opacity(0.5))
                                                                    
                                                                    GeometryReader { geometry in
                                                                        ZStack(alignment: .leading) {
                                                                            Rectangle()
                                                                                .fill(Color.black.opacity(0.5))
                                                                                .frame(width: geometry.size.width, height: geometry.size.height)
                                                                            
                                                                            Rectangle()
                                                                                .fill(Color.white)
                                                                                .frame(
                                                                                    width: geometry.size.width * (Double(item.currentStep) / Double(item.goal)),
                                                                                    height: geometry.size.height
                                                                                )
                                                                        }
                                                                    }
                                                                    .frame(width: 650, height: 12)
                                                                    .cornerRadius(15)
                                                                }
                                                                
                                                                HStack {
                                                                    Text("Prgoress: \(item.currentStep) / \(item.goal)")
                                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                                        .foregroundStyle(Color.white.opacity(0.5))
                                                                    
                                                                    Spacer()
                                                                    
                                                                    Text("Reward: \(item.reward) coins")
                                                                        .font(.custom("PaytoneOne-Regular", size: 14))
                                                                        .foregroundStyle(Color(red: 255/255, green: 255/255, blue: 51/255))
                                                                }
                                                            }
                                                        }
                                                    }
                                                    
                                                    Spacer()
                                                }
                                                .padding(.horizontal)
                                            }
                                    }
                                    .frame(width: 700, height: 130)
                                    .cornerRadius(12)
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
    MisssionsView()
}

