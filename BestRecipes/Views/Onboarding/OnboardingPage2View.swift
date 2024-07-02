//
//  OnboardingPage2View.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 30.06.2024.
//

import SwiftUI

struct OnboardingPage2View: View {
    var body: some View {
        OnboardingSomePageView(
            whiteText: "Recipes with\n",
            orangeText: "each and every\ndetail",
            backgroundImage: .onboardingTwoBackground,
            activeIndicatorIndex: 1,
            bigButtonTitle: "Continue",
            showingSkipButton: true/*,
            destinationView: OnboardingPage3View()*/
        )
    }
}

#Preview {
    OnboardingPage2View()
}
