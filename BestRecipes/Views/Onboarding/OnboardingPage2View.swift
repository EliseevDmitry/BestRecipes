
import SwiftUI

struct OnboardingPage2View: View {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false

    @State private var onboardingPage3ViewIsOn = false
    @State private var homeViewIsOn = false
    
    @ObservedObject var appManager: RecipesManager

    var body: some View {
        ZStack(alignment: .bottom) {
            OnboardingBackgroundView(backgroundImage: .onboardingTwoBackground)
            DarkeningGradientView()
            VStack {
                OnboardingTextView(
                    whiteText: "Recipes with\n",
                    orangeText: "each and every\ndetail"
                )

                IndicatorsView(activeIndicatorIndex: 1)
                
                NavigationLink(isActive: $onboardingPage3ViewIsOn) {
                    OnboardingPage3View(appManager: appManager)
                        .navigationBarBackButtonHidden()
                } label: {
                    ContinueButtonView(title: "Continue") {
                        onboardingPage3ViewIsOn.toggle()
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
    OnboardingPage2View(appManager: RecipesManager())
}
