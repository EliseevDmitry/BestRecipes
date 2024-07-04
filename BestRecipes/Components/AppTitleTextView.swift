//
//  AppTitleTextView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct AppTitleTextView: View {
    var body: some View {
        TitleRowView(text: "Best", offsetHeight: 40)
        TitleRowView(text: "Recipe", offsetHeight: 0)
    }
}

struct TitleRowView: View {
    let text: String
    let offsetHeight: Double
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .font(.custom(Poppins.bold, size: 80))
            .offset(CGSize(width: 0, height: offsetHeight))

    }
}

#Preview {
    AppTitleTextView()
        .preferredColorScheme(.dark)
}
