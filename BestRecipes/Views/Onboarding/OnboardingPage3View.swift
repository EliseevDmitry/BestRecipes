//
//  OnboardingPage3View.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 30.06.2024.
//

import SwiftUI

struct OnboardingPage3View: View {
    var body: some View {
        OnboardingSomePageView(
            whiteText: "Cook it now or\n ",
            orangeText: "save it for later",
            backgroundImage: .onboardingThreeBackground,
            activeIndicatorIndex: 2,
            bigButtonTitle: "Start Cooking",
            showingSkipButton: false/*,
            destinationView: HomeView()*/
        )
    }
}

#Preview {
    OnboardingPage3View()
}

#Preview {
    OnboardingPage2View()
}
