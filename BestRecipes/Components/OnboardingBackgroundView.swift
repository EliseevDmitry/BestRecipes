//
//  OnboardingBackgroundView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct OnboardingBackgroundView: View {
    let backgroundImage: ImageResource
    
    var body: some View {
        Image(backgroundImage)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    OnboardingBackgroundView(backgroundImage: .onboardingThreeBackground)
}
