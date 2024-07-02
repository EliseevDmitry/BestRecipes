//
//  OnboardingPage1View.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 30.06.2024.
//

import SwiftUI

struct OnboardingPage1View: View {
    var body: some View {
        OnboardingSomePageView(
            whiteText: "Recipes from\nall ",
            orangeText: "over the\nWorld",
            backgroundImage: .onboardingOneBackground,
            activeIndicatorIndex: 0,
            bigButtonTitle: "Continue",
            showingSkipButton: true/*, 
            destinationView: OnboardingPage2View()
            */
        )
    }
}

#Preview {
    OnboardingPage1View()
}
