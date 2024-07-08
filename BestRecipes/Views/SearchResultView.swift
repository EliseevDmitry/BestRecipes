//
//  SearchResultView.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 08.07.2024.
//

import SwiftUI

struct SearchResultsView: View {
    var searchResults: [SearchResultRecipe]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(searchResults, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipeId: recipe.id ?? 0)) {
                            Frame1View(id: recipe.id ?? 0, foodFoto: recipe.image ?? "", title: recipe.title ?? "")
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Search Results")
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
        }
    }
}
