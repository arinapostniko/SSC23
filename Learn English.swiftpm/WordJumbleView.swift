import SwiftUI

struct WordJumbleView: View {
    @State private var currentWordIndex = 0
    @State private var shuffledWord = ""
    @State private var userAnswer = ""
    @State private var correctAnswers = 0
    @State private var words = [
        "apple",
        "issue",
        "coast",
        "project",
        "level",
        "theory",
        "skill",
        "novel",
        "crew",
        "scheme",
        "humble"
    ]
    @State private var purplePosition = CGPoint(x: 100, y: 100)
    @State private var bluePosition = CGPoint(x: 750, y: 150)
    @State private var greenPosition = CGPoint(x: 400, y: 800)
    
    var purpleDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.purplePosition = value.location
            }
    }
    
    var blueDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.bluePosition = value.location
            }
    }
    
    var greenDrag: some Gesture {
        DragGesture()
            .onChanged { value in
                self.greenPosition = value.location
            }
    }
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            Image("purple")
                .position(purplePosition)
                .gesture(
                    purpleDrag
                )
            Image("blue")
                .position(bluePosition)
                .gesture(
                    blueDrag
                )
            Image("green")
                .position(greenPosition)
                .gesture(
                    greenDrag
                )
            VStack(spacing: 20) {
                Text("Unscramble the word:")
                    .font(.title)
                    .foregroundColor(.black)
                Text(shuffledWord)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .green],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                
                ZStack(alignment: .leading) {
                    if userAnswer.isEmpty {
                        Text("Enter your answer")
                            .foregroundColor(Color.black)
                    }
                    TextField("", text: $userAnswer)
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 1)
                )
                
                Button("Submit") {
                    checkAnswer()
                }
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
                
                Text("Score: \(correctAnswers)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            }
            .padding()
            .onAppear(perform: resetWord)
        }
    }
    
    func checkAnswer() {
        let answer = userAnswer.trimmingCharacters(in: .whitespacesAndNewlines)
        if answer.lowercased() == words[currentWordIndex].lowercased() {
            correctAnswers += 1
            resetWord()
        } else {
            userAnswer = ""
        }
    }
    
    func resetWord() {
        currentWordIndex = Int.random(in: 0..<words.count)
        let word = words[currentWordIndex]
        shuffledWord = String(word.shuffled())
        userAnswer = ""
    }
}

struct WordJumbleView_Previews: PreviewProvider {
    static var previews: some View {
        WordJumbleView()
    }
}
