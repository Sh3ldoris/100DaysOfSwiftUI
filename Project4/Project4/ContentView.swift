import SwiftUI

// Custom modifier
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(.buttonBorder)
    }
}

// Implement it as extension
extension View {
    public func title() -> some View {
        modifier(Title())
    }
}

// Custom container
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<rows, id: \.self) { row in
                HStack(alignment: .top) {
                    ForEach(0..<columns, id: \.self) { col in
                        content(row, col)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .title()
            
            GridStack(rows: 2, columns: 2) { row, column in
                Text("row \(row), column \(column)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
 
