import SwiftUI

struct DatePickerView: View {
    @State private var wakeUp : Date = Date.now
    
    var body: some View {
        DatePicker("Enter date", selection: $wakeUp)
        
        // Hidden label
        // To disable dates you can provide in range with non-closed range
        DatePicker("Enter date", selection: $wakeUp, in: Date.now...)
            .labelsHidden()
    }
}

#Preview {
    DatePickerView()
}
