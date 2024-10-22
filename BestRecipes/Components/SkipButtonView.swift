
import SwiftUI

struct SkipButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button("Skip", action: action)
            .font(.custom(Poppins.medium, size: 20))
            .foregroundStyle(.white)
            .padding(.bottom, 24)
            .padding(.top, 8)
    }
}

#Preview {
    SkipButtonView(action: {})
        .preferredColorScheme(.dark)
}
