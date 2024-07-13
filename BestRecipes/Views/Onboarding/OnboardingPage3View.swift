
import SwiftUI

struct OnboardingPage3View: View {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    @ObservedObject var appManager: RecipesManager
    @State private var homeViewIsOn = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            OnboardingBackgroundView(backgroundImage: .onboardingThreeBackground)
            DarkeningGradientView()
            VStack {
                OnboardingTextView(
                    whiteText: "Cook it now or\n ",
                    orangeText: "save it for later"
                )
                IndicatorsView(activeIndicatorIndex: 2)
                // кнопка, нажатие на которую ведет на экран HomeView
                NavigationLink(isActive: $homeViewIsOn) {
                    HomeView(appManager: appManager)
                        .navigationBarBackButtonHidden()
                } label: {
                    ContinueButtonView(title: "Start Cooking") {
                        homeViewIsOn.toggle()
                        onboardingIsShow = true
                    }
                }
                RectangleSpacerView()
            }
        }
    }
}

#Preview {
    OnboardingPage3View(appManager: RecipesManager())
}
