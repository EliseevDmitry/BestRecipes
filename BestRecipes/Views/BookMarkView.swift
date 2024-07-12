//
//  BookMarkView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 10.07.2024.
//

import SwiftUI

struct BookMarkView: View {
    @ObservedObject var appManager: RecipesManager
    var networkManager = NetworkManager.shared
    @State private var trendingItems: [Frame1View] = []
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    var body: some View {
        Text("Здесь должен быть экран, на котором собраны блюда, отмеченные закладками пользователя").font(.largeTitle).multilineTextAlignment(.center)
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20) {
                ForEach(trendingItems, id: \.id) { item in
                    NavigationLink(destination: RecipeDetailView(recipeId: item.id)) {
                        item
                            .padding(.leading)
                    }
                }
            }
        }
        //                        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity)
//        .task {
//            if let id = recipeId[Int] {
//                print(id)
//                isLoading = true
//                networkManager.fetchRecipeDetails(for: id) { result in
//                    DispatchQueue.main.async {
//                        isLoading = false
//                        switch result {
//                        case .success(let response):
//                            self.recipeDetails = response
//                        case .failure(let error):
//                            self.errorMessage = "Error: \(error.localizedDescription)"
//                            print("Error: \(error)")
//                        }
//                    }
//                }
//            }
//        }
//        .padding(.horizontal, 10)
    }
}

           


#Preview {
    BookMarkView(appManager: RecipesManager())
}
