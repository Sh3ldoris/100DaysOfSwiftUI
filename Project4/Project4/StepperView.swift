import SwiftUI

struct StepperView: View {
    @State private var stepVal = 8.0
    var body: some View {
        Stepper("Stepper with val: \(stepVal.formatted())", value: $stepVal, in: 4...12, step: 0.25)
    }
}

#Preview {
    StepperView()
}
