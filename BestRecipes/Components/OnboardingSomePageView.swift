//
//  OnboardingPageView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 01.07.2024.
//

import SwiftUI

struct OnboardingSomePageView: View {
    let whiteText: String
    let orangeText: String
    let backgroundImage: ImageResource
    let activeIndicatorIndex: Int
    let bigButtonTitle: String
    let showingSkipButton: Bool
//    let destinationView: any View
    
    var body: some View {
        ZStack(alignment: .bottom) {
            OnboardingBackgroundView(backgroundImage: backgroundImage)
            DarkeningGradientView()            
            VStack {
                OnboardingTextView(whiteText: whiteText, orangeText: orangeText)
                
                IndicatorsView(activeIndicatorIndex: activeIndicatorIndex)
                
                ContinueButtonView(title: bigButtonTitle/*, destinationView: destinationView*/)
                
                if showingSkipButton {
                    SkipButtonView()
                } else {
                    RectangleSpacerView()
                }
            }
        }
    }
}

#Preview {
    OnboardingSomePageView(
        whiteText: "Recipes from\nall ",
        orangeText: "over the\nWorld",
        backgroundImage: .onboardingTwoBackground,
        activeIndicatorIndex: 1,
        bigButtonTitle: "Continue",
        showingSkipButton: true/*,
        destinationView: OnboardingPage3View()*/
    )
}
