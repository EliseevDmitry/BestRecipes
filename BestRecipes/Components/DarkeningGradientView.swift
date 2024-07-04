//
//  DarkeningGradientView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct DarkeningGradientView: View {
    var body: some View {
        Rectangle()
            .foregroundStyle(
                LinearGradient(
                    colors: [
                        .black.opacity(0.0),
                        .black.opacity(0.7)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .ignoresSafeArea()
    }
}

#Preview {
    DarkeningGradientView()
}
