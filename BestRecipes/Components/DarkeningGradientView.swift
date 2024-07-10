
import SwiftUI

struct DarkeningGradientView: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(
                LinearGradient(
                    colors: [
                        .black.opacity(0.0),
                        .black.opacity(0.7)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()
    }
}

#Preview {
    DarkeningGradientView()
}
