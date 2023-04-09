import SwiftUI

struct GuessDefinitionView: View {
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
    @State private var currentWordIndex = 0
    @State private var currentDefinition = ""
    @State private var userAnswer = ""
    @State private var score = 0
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
            VStack(spacing: 30) {
                Text(currentDefinition)
                    .font(.title)
                    .foregroundColor(.black)
                
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
                
                Group {
                    Text("Submit")
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
                    if userAnswer != ""{
                        checkAnswer()
                        nextWord()
                    } else { return }
                }
                
                Text("Score: \(score)")
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
        }
        .onAppear(perform: {
            nextWord()
        })
    }
    
    func checkAnswer() {
        if userAnswer.lowercased() == words[currentWordIndex] {
            score += 1
        }
    }
    
    func nextWord() {
        currentWordIndex = (currentWordIndex + 1) % words.count
        
        switch words[currentWordIndex] {
        case "apple":
            currentDefinition = "A round fruit with a red, green, or yellow skin and a white inside"
        case "issue":
            currentDefinition = "Some situation or event that is thought about"
        case "coast":
            currentDefinition = "The shore of a sea or ocean"
        case "project":
            currentDefinition = "A planned undertaking"
        case "level":
            currentDefinition = "A relative position or degree of value in a graded group"
        case "theory":
            currentDefinition = "A well-substantiated explanation of some aspect of the world"
        case "skill":
            currentDefinition = "An ability that has been acquired by training"
        case "novel":
            currentDefinition = "An extended fictional work in prose"
        case "crew":
            currentDefinition = "The people who work on a vehicle"
        case "scheme":
            currentDefinition = "An elaborate and systematic plan of action"
        case "humble":
            currentDefinition = "Marked by meekness or modesty; not arrogant or prideful"
        default:
            currentDefinition = "Unknown word"
        }
        
        userAnswer = ""
    }
}

struct GuessDefinitionView_Previews: PreviewProvider {
    static var previews: some View {
        GuessDefinitionView()
    }
}
