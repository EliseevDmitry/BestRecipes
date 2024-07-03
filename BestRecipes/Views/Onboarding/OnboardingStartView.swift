//
//  OnboardingStartView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 30.06.2024.
//

import SwiftUI

struct OnboardingStartView: View {
    @State private var onboardingPage1ViewIsOn = false
    
    @ObservedObject var appManager: RecipesManager
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                OnboardingBackgroundView(backgroundImage: .onboardingStartBackground)
                DarkeningGradientView()
                
                VStack {
                    HStack(alignment: .firstTextBaseline) {
                        Image("star")
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
