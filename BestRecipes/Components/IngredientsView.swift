//
//  IngredientsView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct IngredientsView: View {
    var body: some View {
        ZStack {
            Color(.neutral20)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .frame(height: 76)
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.white)
                        .frame(width: 52, height: 52)
                    Image("mockFish")
                        .resizable()
                        .frame(width: 52, height: 52)
                }
                Text("Fish")
                    .font(.custom(Poppins.bold, size: 16))
                Spacer()
                Text("200g")
                    .font(.custom(Poppins.regular, size: 14))
                    .foregroundStyle(.secondary)
                
            }
            .padding(.horizontal, 16)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }
}

#Preview {
    IngredientsView()
}
