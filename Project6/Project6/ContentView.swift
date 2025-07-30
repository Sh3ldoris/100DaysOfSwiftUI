import SwiftUI

struct ContentView: View {
    @State private var words: [String] = []
    @State private var rootWord: String = ""
    @State private var newWord: String = ""
    @State private var score: Int = 0
    
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    @State private var isErrorShown: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    Text("Score: \(score)")
                }
                
                Section {
                    ForEach(words, id: \.self) {word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            
            .toolbar {
                ToolbarItem {
                    Button(action: startGame) {
                        Text("Restart")
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $isErrorShown) {} message: {
                Text(errorMessage)
            }
        }
    }
    
    func addWord() {
        let answer: String = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !answer.isEmpty else { return }
        
        guard isCorrectLength(answer) else {
            showError(title: "Word of wrong length", message: "The word has wrong length!")
            return
        }
        
        guard isOriginalWord(answer) else {
            showError(title: "Word already used", message: "Be more original!")
            return
        }
        
        guard isPossibleWord(answer) else {
            showError(title: "Word not possible", message: "You can't spell that word from \(rootWord)")
            return
        }
        
        guard isRealWord(answer) else {
            showError(title: "Word not recognized", message: "You can't make that word!")
            return
        }
        
        
        score += (words.count + 1) * answer.count
    
        
        withAnimation {
            words.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    func startGame() {
        words = [String]()
        newWord = ""
        score = 0
        
        if let startWordsFile = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWordsFileContent = try? String(contentsOf: startWordsFile, encoding: .utf8) {
                let startWords: [String] = startWordsFileContent.components(separatedBy: "\n")
                // Assign random word from file
                rootWord = startWords.randomElement() ?? "Word"
                return
            }
        }
        
        fatalError("Error loading start words")
    }
    
    func isCorrectLength(_ word: String) -> Bool {
        return word.count <= rootWord.count && word.count >= 3
    }
    
    func isOriginalWord(_ word: String) -> Bool {
        !words.contains(where: { $0.lowercased() == word.lowercased() })
    }
    
    func isPossibleWord(_ word: String) -> Bool {
        var tempRoot = rootWord.lowercased()
            
            for letter in word.lowercased() {
                if let index = tempRoot.firstIndex(of: letter) {
                    tempRoot.remove(at: index)
                } else {
                    return false
                }
            }
            
            return true
    }
    
    func isRealWord(_ word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf8.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func showError(title: String, message: String) -> Void {
        errorTitle = title
        errorMessage = message
        isErrorShown = true
    }
}

#Preview {
    ContentView()
}
