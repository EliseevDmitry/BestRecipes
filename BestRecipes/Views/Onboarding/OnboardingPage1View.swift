
import SwiftUI

struct OnboardingPage1View: View {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false

    @State private var onboardingPage2ViewIsOn = false
    @State private var homeViewIsOn = false
    
    @ObservedObject var appManager: RecipesManager

    var body: some View {
        ZStack(alignment: .bottom) {
            OnboardingBackgroundView(backgroundImage: .onboardingOneBackground)
            DarkeningGradientView()
            VStack {
                OnboardingTextView(
                    whiteText: "Recipes from\nall ",
                    orangeText: "over the\nWorld"
                )

                IndicatorsView(activeIndicatorIndex: 0)
                
                NavigationLink(isActive: $onboardingPage2ViewIsOn) {
                    OnboardingPage2View(appManager: appManager)
                        .navigationBarBackButtonHidden()
                } label: {
                    ContinueButtonView(title: "Continue") {
                        onboardingPage2ViewIsOn.toggle()
                    }
                }
                               
                NavigationLink(isActive: $homeViewIsOn) {
                    HomeView(appManager: appManager)
                        .navigationBarBackButtonHidden()
                } label: {
                    SkipButtonView() {
                        homeViewIsOn.toggle()
                        onboardingIsShow = true
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingPage1View(appManager: RecipesManager())
}
