
import SwiftUI

struct OnboardingBackgroundView: View {
    let backgroundImage: ImageResource
    
    var body: some View {
        Image(backgroundImage)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    OnboardingBackgroundView(backgroundImage: .onboardingThreeBackground)
}
