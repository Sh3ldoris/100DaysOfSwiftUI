import SwiftUI

struct ContentView: View {
    let tipOptions: [Double] = [0.2, 0.15, 0.1, 0]
    let currencyCode: String = Locale.current.currency?.identifier ?? "EUR"
    
    @State private var amount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Double = 0.15
    @FocusState private var isAmountFocused: Bool
    
    // Computed value
    var totalPerPerson: Double {
        let totalAmount = amount * (1 + tipPercentage)
        return totalAmount / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Amount inputs sectio
                Section {
                    TextField("Amount", value: $amount, format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2...20, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                // Tip picker section
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipOptions, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                
                // Final spilted check amount section
                Section("Final value per person") {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                }
            }
            .navigationTitle("SplitBill")
            .toolbar {
                if isAmountFocused {
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
