import SwiftUI

struct AnimationsView: View {
    @State private var animationAmount = 1.0
    @State private var dragAmount: CGSize = CGSize.zero
    
    var body: some View {
        VStack {
            // Dragable card
            LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(width: 300, height: 200)
                .clipShape(.rect(cornerRadius: 10))
                .offset(dragAmount)
                .gesture(
                    DragGesture()
                        .onChanged {
                            self.dragAmount = $0.translation
                        }
                        .onEnded { _ in
                            // Animate only when drag released
                            withAnimation(.bouncy) {
                                self.dragAmount = .zero
                            }
                        }
                )
                // Animate whole dragging
//                .animation(.bouncy, value: dragAmount)
            
            Button("Animated") {
                //animationAmount += 1
            }
            .padding(40)
            .background(.red)
            .foregroundStyle(.white)
            .clipShape(.circle)
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(
                        .easeOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: animationAmount
                    )
            )
            .onAppear {
                animationAmount = 2.0
            }
        }
    }
}

#Preview {
    AnimationsView()
}
