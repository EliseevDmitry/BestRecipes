//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct RecipeDetailView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                // видео
                VStack {
                    Image("mockImage1")
                        .resizable()
                        .frame(height: 200)
                        .cornerRadius(8)
                    // рейтинг
                    HStack {
                        Image(systemName: "star.fill")
                            .font(.system(size: 16))
                        Text("4,5")
                            .font(.custom(Poppins.bold, size: 14))
                        Text("(300 Reviews)")
                            .font(.custom(Poppins.regular, size: 14))
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    // инструкция
                    HStack {
                        Text("Instructions")
                            .font(.custom(Poppins.bold, size: 20))
                        Spacer()
                    }
                    Text("Place eggs in a saucepan and cover with cold water. Bring water to a boil and immediately remove from heat. Cover and let eggs stand in hot water for 10 to 12 minutes. Remove from hot water, cool, peel, and chop.Place chopped eggs in a bowl. Add chopped tomatoes, corns, lettuce, and any other vegitable of your choice. Stir in mayonnaise, green onion, and mustard. Season with paprika, salt, and pepper. Stir and serve on your favorite bread or crackers.")
                        .font(.custom(Poppins.regular, size: 16))
                    // ингридиенты
                    HStack {
                        Text("Ingridients")
                            .font(.custom(Poppins.bold, size: 20))
                        Spacer()
                        Text("5 items")
                            .font(.custom(Poppins.regular, size: 14))
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 19)
                    // табличка с ингридиентами
                    LazyVStack {
                        IngredientsView()
                        IngredientsView()
                    }

                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Recipe detail")
        }
    }
}

#Preview {
    RecipeDetailView()
}
