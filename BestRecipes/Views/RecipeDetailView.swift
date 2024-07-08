//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipeId: Int?
    var cuisine: String?

    var body: some View {
        Text("Recipe  View for recipeID \(String(describing: recipeId))")
            .navigationTitle("Recipe Detail")
    }
}

#Preview {
    RecipeDetailView(recipeId: 1222)
}
