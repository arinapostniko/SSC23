import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            TabView {
                GuessDefinitionView()
                    .tabItem {
                        Text("Guess the Definition")
                    }
                GrammarQuizView()
                    .tabItem {  
                        Text("Grammar Quiz")
                    }
                WordJumbleView()
                    .tabItem { 
                        Text("Word Jumble")
                    }
            }
        }
    }
}
