//
//  ContinueButtonView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct ContinueButtonView: View {
    let title: String
//    let destinationView: any View
    
    var body: some View {
        Button(title) {
            //NavigationLink("title", destination: destinationView)
        }
        .frame(width: 250)
        .padding()
        .font(.custom(Poppins.SemiBold, size: 30))
        .background(.pinkish)
        .foregroundStyle(.white)
        .clipShape(.capsule)
    }
}

#Preview {
    ContinueButtonView(title: "Continue"/*, destinationView: OnboardingPage2View()*/)
}
