//
//  OnboardingTextView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct OnboardingTextView: View {
    let whiteText: String
    let orangeText: String
    
    var body: some View {
        Text("\(twoColorsText())")
            .font(.custom(Poppins.Bold, size: 40))
            .multilineTextAlignment(.center)
            .padding(.bottom, 16)
    }
    
    private func twoColorsText() -> Text {
        Text(whiteText).foregroundColor(.white) + Text(orangeText).foregroundColor(.secondary20)
    }
}

#Preview {
    OnboardingTextView(whiteText: "hello ", orangeText: "world")
        .preferredColorScheme(.dark)
}
