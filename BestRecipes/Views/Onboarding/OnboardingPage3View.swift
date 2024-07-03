//
//  OnboardingPage3View.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 30.06.2024.
//

import SwiftUI

struct OnboardingPage3View: View {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    
    @State private var homeViewIsOn = false
    
    @ObservedObject var appManager: RecipesManager

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
