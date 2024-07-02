//
//  RectangleSpacerView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct RectangleSpacerView: View {
    var body: some View {
        Rectangle()
            .opacity(0)
            .frame(height: 40)
    }
}

#Preview {
    RectangleSpacerView()
}
