//
//  test.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 08.07.2024.
//

import SwiftUI

struct test: View {
    @State private var trendingItems: [TestFrame] = [TestFrame(id: 1, foodFoto: "https://img.spoonacular.com/recipes/782601-312x231.jpg", title: "fvfvnfvfnvhfvjsdjnvjnjsfbjvdfbvbjfsvbjs"), TestFrame(id: 2, foodFoto: "https://img.spoonacular.com/recipes/782601-312x231.jpg", title: "fvfvnfvfnvhfvjsdjnvjnjsfbjvdfbvbjfsvbjs"), TestFrame(id: 3, foodFoto: "https://img.spoonacular.com/recipes/782601-312x231.jpg", title: "fvfvnfvfnvhfvjsdjnvjnjsfbjvdfbvbjfsvbjs")]
    var body: some View {
        Spacer()
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(trendingItems, id: \.self) { item in
                    NavigationLink(destination: RecipeDetailView(recipeId: item.id)) {
                        item
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        Spacer()
    }
}

#Preview {
    test()
}
