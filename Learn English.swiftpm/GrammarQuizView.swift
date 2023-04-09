import SwiftUI

struct GrammarQuizView: View {
    @State private var questions = [
        Question(text: "He _____ football every Sunday.", options: ["play", "plays", "playing"], answerIndex: 1),
        Question(text: "The library _____ at 9 PM.", options: ["close", "closes", "closed"], answerIndex: 1),
        Question(text: "I _____ my homework every day.", options: ["do", "does", "doing"], answerIndex: 0),
        Question(text: "We _____ to New York next week.", options: ["fly", "flies", "flying"], answerIndex: 0),
        Question(text: "My sister _____ in the living room now.", options: ["study", "studies", "studying"], answerIndex: 1),
        Question(text: "She _____ to work every day.", options: ["drives", "drive", "driving"], answerIndex: 0),
        Question(text: "I _____ a book when he called me.", options: ["reading", "reads", "read"], answerIndex: 2),
        Question(text: "He _____ his homework every day.", options: ["doing", "does", "do"], answerIndex: 1),
        Question(text: "They _____ in the park yesterday.", options: ["playing", "plays", "play"], answerIndex: 2),
        Question(text: "My friends _____ to the beach last weekend.", options: ["going", "goes", "go"], answerIndex: 2)
    ]
    @State private var currentQuestionIndex = 0
    @State private var userAnswerIndex: Int? = nil
    @State private var score = 0
    @State private var quizFinished = false
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
                if !quizFinished {
                    QuestionView(question: questions[currentQuestionIndex], userAnswerIndex: $userAnswerIndex)
                        .padding()
                    
                    Button(action: {
                        checkAnswer()
                        nextQuestion()
                    }) {
                        Text("Next")
                    }
                    .disabled(userAnswerIndex == nil)
                    .padding()
                    .padding(.horizontal, 40)
                    .foregroundColor(.white)
                    .background(
                        LinearGradient(
                            colors: [.purple, .blue],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .cornerRadius(100)
                } else {
                    Text("Quiz finished! Score: \(score)/\(questions.count)")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .green],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .padding()
                }
            }
        }
        .onAppear(perform: {
            questions.shuffle()
        })
    }
    
    func checkAnswer() {
        if let userAnswerIndex = userAnswerIndex {
            if userAnswerIndex == questions[currentQuestionIndex].answerIndex {
                score += 1
            }
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        userAnswerIndex = nil
        
        if currentQuestionIndex >= questions.count {
            quizFinished = true
        }
    }
}

struct GrammarQuizView_Previews: PreviewProvider {
    static var previews: some View {
        GrammarQuizView()
    }
}

struct Question {
    let text: String
    let options: [String]
    let answerIndex: Int
}

struct QuestionView: View {
    let question: Question
    @Binding var userAnswerIndex: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(question.text)
                .font(.title2)
                .foregroundColor(.black)
                .padding(.bottom, 10)
            
            ForEach(0..<question.options.count) { index in
                Button(action: {
                    userAnswerIndex = index
                }) {
                    Text(question.options[index])
                        .padding()
                        .foregroundColor(userAnswerIndex == index ? .white : .black)
                        .background(userAnswerIndex == index ? Color.blue : Color.gray.opacity(0.2))
                        .cornerRadius(75)
                }
                .disabled(userAnswerIndex != nil)
            }
        }
    }
}
