//
//  TestBTN.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 05.07.2024.
//

import SwiftUI

struct PopularCategoryButton: View {
    let title: String
    @Binding var selectedCategory: String
    let action: () -> Void

    var body: some View {
        Button(action: {
            selectedCategory = title
            action()
        }) {
            Text(title)
                .padding(5)
                .padding(.horizontal, 8)
                .font(.custom(Poppins.semiBold, size: 12))
                .background(selectedCategory == title ? Color.primary50 : Color.neutral10)
                .foregroundStyle(selectedCategory == title ? .white : .primary41)
                .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}


