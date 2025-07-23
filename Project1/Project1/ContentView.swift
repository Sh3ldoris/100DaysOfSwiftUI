import SwiftUI

struct ContentView: View {
    let options: [String] = ["Option 1", "Option 2", "Option 3"]
    // Define that this var is mutating this struct
    // It is design to store private properties only for current view
    @State private var tapCount = 0
    // Property for storing text input value
    @State private var name: String = ""
    @State private var selectedOption: String = "Option 1"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // $ sign defines that the name property is used in a 2 way binding manner
                    TextField("Enter your name", text: $name)
                    Text("Hello World" + (name.isEmpty ? "!" : ", \(name)"))
                }
                Section {
                    Picker("Select option", selection: $selectedOption) {
                        // id is for tracking changes
                        ForEach(options, id: \.self) { option in
                            Text(option)
                        }
                    }
                }
                Section {
                    Text("Text 1")
                    Text("Text 2")
                    Text("Text 3")
                }
                Section {
                    ForEach(1..<10) { index in
                        Text("Line \(index)")
                    }
                }
            }
            .navigationTitle("Project one")
            .navigationBarTitleDisplayMode(.inline)
            Button("Tap count: \(tapCount)") {
                tapCount += 1
            }
        }
    }
}

#Preview {
    ContentView()
}
