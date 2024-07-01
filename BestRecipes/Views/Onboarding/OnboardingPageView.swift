//
//  OnboardingPageView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 01.07.2024.
//

import SwiftUI

struct OnboardingPageView: View {
    let whiteText: String
    let orangeText: String
    let backgroundImage: ImageResource
    let activeIndicatorIndex: Int
    let bigButtonTitle: String
    let showingSkipButton: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            OnboardingBackgroundView(backgroundImage: backgroundImage)
            
            VStack {
                OnboardingTextView(whiteText: whiteText, orangeText: orangeText)
    
                IndicatorsView(activeIndicatorIndex: activeIndicatorIndex)
                
                ContinueButtonView(title: bigButtonTitle)
                
                if showingSkipButton {
                    SkipButtonView()
                } else {
                    Rectangle()
                        .opacity(0)
                        .frame(height: 40)
                }
            }
        }
    }
}

struct DarkeningLayerView: View {
    var body: some View {
        Color.black.opacity(Constants.darkeningLevel)
            .ignoresSafeArea()
    }
}

struct OnboardingBackgroundView: View {
    let backgroundImage: ImageResource
    
    var body: some View {
        Image(backgroundImage)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        DarkeningLayerView()
    }
}

struct OnboardingTextView: View {
    let whiteText: String
    let orangeText: String
    
    var body: some View {
        Text("\(twoColorsText())")
            .font(.custom(Poppins.Bold, size: 35))
            .multilineTextAlignment(.center)
            .padding(.bottom, 16)
    }
    
    private func twoColorsText() -> Text {
        Text(whiteText).foregroundColor(.white) + Text(orangeText).foregroundColor(.rating100)
    }
}

struct ContinueButtonView: View {
    let title: String
    
    var body: some View {
        Button(title) {
            // destination view
        }
        .frame(width: 200)
        .padding()
        .font(.custom(Poppins.Bold, size: 20))
        .background(.error100)
        .foregroundStyle(.white)
        .clipShape(.capsule)
    }
}

struct SkipButtonView: View {
    var body: some View {
        Button("Skip") {
            // destination view
        }
        .font(.custom(Poppins.Medium, size: 20))
        .foregroundStyle(.white)
        .padding(.bottom, 24)
        .padding(.top, 8)
    }
}

#Preview {
    OnboardingPageView(
        whiteText: "Recipes from\nall ",
        orangeText: "over the\nWorld",
        backgroundImage: .onboardingThreeBackground,
        activeIndicatorIndex: 1,
        bigButtonTitle: "Continue",
        showingSkipButton: false
    )
}




