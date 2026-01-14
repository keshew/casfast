import SwiftUI

struct RocketRushView: View {
    @StateObject var viewModel =  RocketRushViewModel()
    @State  var level = UserDefaultsManager.shared.currentLevel
    @Environment(\.presentationMode) var presentationMode
    @State private var progress: CGFloat = 0.0
    @State private var displayedMultiplier: CGFloat = 1.0
    @State private var isPlaying: Bool = false
    @State private var timer: Timer? = nil
    let gird = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State private var multiplierHistory: [CGFloat] = UserDefaults.standard.array(forKey: "multiplierHistory") as? [CGFloat] ?? []
    @State private var shakeOffset: CGFloat = 0
    @State private var isFalling: Bool = false
    @State private var isShaking = false
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            ZStack(alignment: .bottom) {
                ZStack(alignment: .top) {
                    Color.black.ignoresSafeArea()
                        .overlay {
                            Image("rbg")
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
                        
                        Color(red: 188/255, green: 0/255, blue: 218/255)
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
                        .fill(LinearGradient(colors: [Color(red: 255/255, green: 0/255, blue: 4/255),
                                                      Color(red: 255/255, green: 136/255, blue: 0/255)], startPoint: .leading, endPoint: .trailing))
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(red: 176/255, green: 38/255, blue: 255/255).opacity(0.4))
                                .overlay {
                                    Text("Rocket Rush")
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
                            .frame(height: 200)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 255/255, green: 107/255, blue: 53/255), lineWidth: 5)
                                    .overlay {
                                        ZStack(alignment: .bottomLeading) {
                                            Rectangle()
                                                .fill(Color(red: 38/255, green: 19/255, blue: 30/255).opacity(0.0))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 14)
                                                        .stroke(Color(red: 154/255, green: 6/255, blue: 223/255), lineWidth: 0)
                                                        .overlay(
                                                            VStack {
                                                                Text("X \(String(format: "%.2f", displayedMultiplier))")
                                                                    .font(.custom("PaytoneOne-Regular", size: 20))
                                                                    .foregroundStyle(Color(red: 255/255, green: 137/255, blue: 0/255))
                                                                
                                                                Image("rocket")
                                                                    .resizable()
                                                                    .aspectRatio(contentMode: .fit)
                                                                    .frame(width: 60, height: 70)
                                                                    .padding(.top)
                                                                    .rotationEffect(.degrees(rotationAngle))
                                                                    .offset(x: isShaking ? shakeOffset : 0, y: isFalling ? 250 : 0)
                                                                    .animation(.linear(duration: 0.1).repeat(while: isShaking), value: isShaking)

                                                                Spacer()
                                                            }
                                                        )
                                                )
                                                .frame(height: 200)
                                                .cornerRadius(14)
                                            
                                            GeometryReader { geo in
                                                ZStack(alignment: .bottomLeading) {
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [.red.opacity(0.7)]),
                                                        startPoint: .bottom,
                                                        endPoint: .top
                                                    )
                                                    .mask(
                                                        Path { path in
                                                            let width = geo.size.width
                                                            let height = geo.size.height
                                                            let diagProgress = progress
                                                            
                                                            path.move(to: CGPoint(x: width * diagProgress, y: height * (1 - diagProgress)))
                                                            path.addLine(to: CGPoint(x: width * diagProgress, y: height))
                                                            path.addLine(to: CGPoint(x: 0, y: height))
                                                            path.closeSubpath()
                                                        }
                                                    )
                                                    
                                                    Path { path in
                                                        let width = geo.size.width
                                                        let height = geo.size.height
                                                        let diagProgress = progress
                                                        
                                                        path.move(to: CGPoint(x: 0, y: height))
                                                        path.addLine(to: CGPoint(x: width * diagProgress, y: height * (1 - diagProgress)))
                                                    }
                                                    .stroke(Color.red, lineWidth: 3)
                                                }
                                            }
                                            
                                            .frame(width: 306, height: 218)
                                            .onTapGesture {
                                                withAnimation(.easeInOut(duration: 0.4)) {
                                                    progress += 0.1
                                                    if progress > 0.4 { progress = 0.1 }
                                                }
                                            }
                                            .offset(x: 8, y: -2)
                                        }
                                    }
                            }
                            .cornerRadius(12)
                            .padding(.horizontal)
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
                        if isPlaying {
                            timer?.invalidate()
                            timer = nil
                            finalizeGame()
                            isShaking = false
                            shakeOffset = 0
                            isFalling = false
                        } else {
                            launchAction()
                        }
                    }) {
                        Rectangle()
                            .fill(LinearGradient(colors: [Color(red: 197/255, green: 54/255, blue: 226/255)], startPoint: .leading, endPoint: .trailing))
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white)
                                    .overlay {
                                        HStack {
                                            Text(isPlaying ? "OWN" : "LAUNCH")
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
                    Image("spirewin")
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
    
    func launchAction() {
        guard !isPlaying else { return }
        guard viewModel.bet <= viewModel.coin else {
            return
        }
        UserDefaultsManager.shared.incrementAchievement("fastGamePlays")
        rotationAngle = 0
        isPlaying = true
        isFalling = false
        viewModel.coin -= viewModel.bet
        UserDefaultsManager.shared.removeCoins(viewModel.bet)
        progress = 0.0
        displayedMultiplier = 1.0
        viewModel.multiplierTextColor = Color(red: 141/255, green: 1/255, blue: 198/255)

        let won = Bool.random()
        
        withAnimation(Animation.linear(duration: 0.1).repeatForever(autoreverses: true)) {
            isShaking = true
            shakeOffset = 10
        }

        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { t in
            if progress < 0.4 {
                progress += 0.01
                displayedMultiplier = 1.0 + progress * 3
                
                if !won && progress > 0.05 && Bool.random() {
                    rotationAngle = 120
                    viewModel.multiplierTextColor = .red
                    isPlaying = false
                    withAnimation(.easeIn(duration: 0.8)) {
                        isFalling = true
                    }
                    t.invalidate()
                    timer = nil
              
                    withAnimation(.easeIn(duration: 0.8)) {
                        shakeOffset = 0
                    }
        
                }
            } else {
                t.invalidate()
                timer = nil
                finalizeGame()
   
                withAnimation {
                    isShaking = false
                    shakeOffset = 0
                    isFalling = false
                }
            }
        }
    }

    func finalizeGame() {
        viewModel.multiplierTextColor = .green
        let winAmount = Int(CGFloat(viewModel.bet) * displayedMultiplier)
        viewModel.win = winAmount
        viewModel.coin += winAmount
     
        UserDefaultsManager.shared.addCoins(winAmount)
        isPlaying = false
        
        multiplierHistory.append(displayedMultiplier)
        UserDefaults.standard.set(multiplierHistory, forKey: "multiplierHistory")
    }

    func getMultiplierHistory() -> [CGFloat] {
        return multiplierHistory
    }
    
    func fillColor(for index: Int) -> Color {
        switch index % 4 {
        case 0:
            return Color(red: 202/255, green: 0/255, blue: 171/255).opacity(0.5)
        case 1:
            return Color(red: 0/255, green: 201/255, blue: 34/255).opacity(0.5)
        case 2:
            return Color(red: 12/255, green: 12/255, blue: 201/255).opacity(0.5)
        default:
            return Color(red: 202/255, green: 0/255, blue: 171/255).opacity(0.5)
        }
    }
}

#Preview {
    RocketRushView()
}

extension Animation {
    func `repeat`(while condition: Bool, autoreverses: Bool = true) -> Animation {
        if condition {
            return self.repeatForever(autoreverses: autoreverses)
        } else {
            return self
        }
    }
}
