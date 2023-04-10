import SwiftUI

struct ContentView: View {
    @State private var proceed = false
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    @State private var animationAmount = 10
    
    let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    let colors = [Color(#colorLiteral(red: 0.4550631046, green: 0.6557807326, blue: 0.9979295135, alpha: 1.0)), Color(#colorLiteral(red: 0.8899818659, green: 0.5725648999, blue: 0.9975566268, alpha: 1.0)), Color(#colorLiteral(red: 0.4156862745, green: 0.7098039216, blue: 0.9294117647, alpha: 1)), Color(#colorLiteral(red: 0.337254902, green: 0.1137254902, blue: 0.7490196078, alpha: 1)), Color(#colorLiteral(red: 0.6933748722, green: 0.8683621287, blue: 0.5471815467, alpha: 1.0))]
    
    var body: some View {
        return Group {
            if proceed == true {
                MainView()
            } else {
                ZStack {
//                    Color.white
                    LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
                        .animation(
                            .easeInOut(duration: 10)
                            .repeatForever(autoreverses: true)
                            .speed(0.5),
                            value: animationAmount
                        )
                        .onReceive(timer, perform: { _ in
                            self.start = UnitPoint(x: 4, y: 0)
                            self.end = UnitPoint(x: 0, y: 2)
                            self.start = UnitPoint(x: -4, y: 20)
                            self.start = UnitPoint(x: 4, y: 0)
                        })
//                        .ignoresSafeArea()
                    VStack {
                        Text("Learn English")
                            .font(.system(size: 45))
                            .fontWeight(.semibold)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                        Group {
                            Text("Let's go")
                                .padding()
                                .padding(.horizontal, 45)
                                .foregroundColor(.white)
                                .background(
                                    LinearGradient(
                                        colors: [.purple, .blue],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(100)
                        }
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.75)) {
                                proceed = true
                            }
                        }
                    }
                }
            }
        }
    }
}

