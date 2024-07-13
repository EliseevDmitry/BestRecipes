import SwiftUI

struct OnboardingStartView: View {
    @ObservedObject var appManager: RecipesManager
    @State private var onboardingPage1ViewIsOn = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                OnboardingBackgroundView(backgroundImage: .onboardingStartBackground)
                DarkeningGradientView()
                VStack {
                    HStack(alignment: .firstTextBaseline) {
                        Image("Star")
                        AppSloganTextView(text: "100k+ Premium recipes")
                    }
                    Spacer()
                    AppTitleTextView()
                    AppSloganTextView(text: "Find best recipes for cooking")
                    NavigationLink(isActive: $onboardingPage1ViewIsOn) {
                        OnboardingPage1View(appManager: appManager)
                            .navigationBarBackButtonHidden()
                    } label: {
                        StartButtonView(title: "Get Started") {
                            onboardingPage1ViewIsOn.toggle()
                        }
                    }
                }
                .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    OnboardingStartView(appManager: RecipesManager())
}
