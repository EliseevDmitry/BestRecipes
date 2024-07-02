//
//  SkipButtonView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct SkipButtonView: View {
    var body: some View {
        Button("Skip") {
//            NavigationLink("Skip", destination: HomeView())
        }
        .font(.custom(Poppins.Medium, size: 20))
        .foregroundStyle(.white)
        .padding(.bottom, 24)
        .padding(.top, 8)
    }
}

#Preview {
    SkipButtonView()
        .preferredColorScheme(.dark)
}
