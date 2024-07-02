//
//  OnboardingStartView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 30.06.2024.
//

import SwiftUI

struct OnboardingStartView: View {
    @State private var onboardingPage1ViewIsOn = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                OnboardingBackgroundView(backgroundImage: .onboardingStartBackground)
                DarkeningGradientView()
                VStack {
                    // TODO: - to add a star icon in this text
                    AppSloganTextView(text: "100k+ Premium recipes")
                    Spacer()
                    AppTitleTextView()
                    AppSloganTextView(text: "Find best recipes for cooking")
                    
                    
//                    NavigationLink(destination: OnboardingPage1View()) {
//                        StartButtonView(title: "Get Started")
//                    }
                    
                    
                    NavigationLink(isActive: $onboardingPage1ViewIsOn) {
                        OnboardingPage1View()
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
    OnboardingStartView()
}
