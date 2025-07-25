import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
        .shuffled()
    @State private var correctAnswerIndex: Int = Int.random(in: 0...2)
    @State private var isShowingScore: Bool = false
    @State private var answerAlertTitle: String = ""
    @State private var answerAlertMessage: String = ""
    @State private var score: Int = 0
    @State private var rounds: Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.3), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.16, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Quess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    // Instructions
                    VStack {
                        Text("Tap the flag off")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswerIndex])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    // Flags options
                    ForEach(0...2, id: \.self) { index in
                        Button {
                            tapFlag(index: index)
                        } label: {
                            Image(countries[index])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 3)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                Spacer()
            }
            .padding()
        }
        .alert(answerAlertTitle, isPresented: $isShowingScore) {
            Button(rounds < 8 ? "Continue" : "Restart", action: {
                if rounds >= 8 {
                    score = 0
                    rounds = -1
                }
                nextQuestion()
            })
        } message: {
            Text(answerAlertMessage)
        }
    }
    
    // Evaluete tapped flag
    func tapFlag(index: Int) -> Void {
        let isCorrect: Bool = index == correctAnswerIndex
        isShowingScore = true
        if (isCorrect) {
            answerAlertTitle = "Correct!"
            score += 1
            answerAlertMessage = "Your score is \(score)"
        } else {
            answerAlertTitle = "Wrong!"
            answerAlertMessage = "The correct flag is \(countries[correctAnswerIndex])"
        }
        
        if (rounds >= 8) {
            answerAlertMessage += "\n The game is over\n Your final score is \(score)"
        }
    }
    
    // Get next question
    func nextQuestion() -> Void {
        correctAnswerIndex = Int.random(in: 0...2)
        countries = countries.shuffled()
        rounds += 1
    }
}

#Preview {
    ContentView()
}
