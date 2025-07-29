import CoreML
import SwiftUI

struct BetterRestView: View {
    @State private var wakeUp: Date = defaultWakeUp
    @State private var sleepAmount: Double = 8.0
    @State private var coffeeAmount: Int = 0
    
    static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components)!
    }
    
    var sleepTimeFormatted: String? {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hourInSeconds = (components.hour ?? 0) * 60 * 60
            let minuteInSeconds = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hourInSeconds + minuteInSeconds), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
        
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return nil
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Targeted time
                Section("When do you want to wake up?") {
                    DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                }
                // Wanted sleep
                Section("Desired amount of sleep?") {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                // Coffee
                Section("Daily coffee intake?") {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        // id is for tracking changes
                        ForEach(0...10, id: \.self) {
                            Text("^[\($0) cup](inflect: true)")
                        }
                    }
                }
                
                
                if (sleepTimeFormatted != nil) {
                    Section("Your ideal bed time") {
                        HStack {
                            Text("You should go to sleep at")
                            Spacer()
                            Text(sleepTimeFormatted ?? "")
                        }
                    }
                }
            }
            .navigationTitle("BetterRest")
        }
    }
}

#Preview {
    BetterRestView()
}
