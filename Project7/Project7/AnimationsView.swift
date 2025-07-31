import SwiftUI

struct AnimationsView: View {
    @State private var animationAmount = 1.0
    
    var body: some View {
        VStack {
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
