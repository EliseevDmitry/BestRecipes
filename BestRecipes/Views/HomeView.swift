//
//  ContentView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    
    @ObservedObject var appManager: RecipesManager
    @State private var searchResults: [SearchResultRecipe] = []
    var networkManager = NetworkManager.shared
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Home View!")
                .font(.custom(Poppins.light, size: 30))
            Button("Сбросить данные onboarding") {
                onboardingIsShow = true
                networkManager.searchRecipe(for: "pasta") { result in
                    switch result {
                    case .success(let response):
                        DispatchQueue.main.async {
                            self.searchResults = response.results
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
            
            List(searchResults, id: \.id) { recipe in
                VStack(alignment: .leading) {
                    Text(recipe.title ?? "No title")
                        .font(.headline)
                    if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                        AsyncImage(url: url)
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)
                    }
                }
            }
        }
        
    }
}

#Preview {
    HomeView(appManager: RecipesManager())
}
