//
//  NetworkTestView.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 03.07.2024.
//


import SwiftUI

struct TestSearchView: View {
    @State private var searchResults: [SearchResultRecipe] = []
    @State private var recipeDetails: RecipeInformation?
    @State private var isLoading = false
    @State private var errorMessage: String?
    @State private var requestUrl: String?
    var networkManager = NetworkManager.shared
    
    var body: some View {
        VStack {
            Button("Поиск по кухням") {
                isLoading = true
                errorMessage = nil
                searchResults = []
                networkManager.fetchCuisine(for: "Chinese") { result in
                    DispatchQueue.main.async {
                        isLoading = false
                        switch result {
                        case .success(let response):
                            self.searchResults = response.results
                            if response.results.isEmpty {
                                self.errorMessage = "No recipes found."
                            }
                        case .failure(let error):
                            self.errorMessage = "Error: \(error.localizedDescription)"
                            print("Error: \(error)")
                        }
                    }
                }
            }
            .padding()
            
            Button("Популярные категории") {
                isLoading = true
                errorMessage = nil
                searchResults = []
                networkManager.fetchPopularCategory(for: "salad") { result in
                    DispatchQueue.main.async {
                        isLoading = false
                        switch result {
                        case .success(let response):
                            self.searchResults = response.results
                            if response.results.isEmpty {
                                self.errorMessage = "No recipes found."
                            }
                        case .failure(let error):
                            self.errorMessage = "Error: \(error.localizedDescription)"
                            print("Error: \(error)")
                        }
                    }
                }
            }
            .padding()
            
            Button("Трендовые рецепты") {
                isLoading = true
                errorMessage = nil
                searchResults = []
                networkManager.fetchTrendingRecipes { result in
                    DispatchQueue.main.async {
                        isLoading = false
                        switch result {
                        case .success(let response):
                            self.searchResults = response.results
                            if response.results.isEmpty {
                                self.errorMessage = "No recipes found."
                            }
                        case .failure(let error):
                            self.errorMessage = "Error: \(error.localizedDescription)"
                            print("Error: \(error)")
                        }
                    }
                }
            }
            .padding()
            
            Button("Поиск рецептов пасты") {
                isLoading = true
                errorMessage = nil
                searchResults = []
                networkManager.searchRecipe(for: "pasta") { result in
                    DispatchQueue.main.async {
                        isLoading = false
                        switch result {
                        case .success(let response):
                            self.searchResults = response.results
                            if response.results.isEmpty {
                                self.errorMessage = "No recipes found."
                            }
                        case .failure(let error):
                            self.errorMessage = "Error: \(error.localizedDescription)"
                            print("Error: \(error)")
                        }
                    }
                }
            }
            .padding()
            
            if let requestUrl = requestUrl {
                Text("URL запроса: \(requestUrl)")
                    .padding()
            }
            
            if isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(searchResults, id: \.id) { recipe in
                    VStack(alignment: .leading) {
                        HStack {
                            if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                                AsyncImage(url: url)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60, height: 60)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .padding(.trailing, 10)
                            }
                            VStack(alignment: .leading) {
                                Text("ID: \(recipe.id ?? 0)")
                                    .font(.subheadline)
                                Text(recipe.title ?? "No title")
                                    .font(.headline)
                                    .lineLimit(2)
                            }
                        }
                        Button("Показать детали") {
                            if let id = recipe.id {
                                isLoading = true
                                networkManager.fetchRecipeDetails(for: id) { result in
                                    DispatchQueue.main.async {
                                        isLoading = false
                                        switch result {
                                        case .success(let response):
                                            self.recipeDetails = response
                                        case .failure(let error):
                                            self.errorMessage = "Error: \(error.localizedDescription)"
                                            print("Error: \(error)")
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 5)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .onAppear {
            // Вывести URL в консоль и на экран
            if let url = networkManager.createURL(for: .doSearch(request: "pasta")) {
                self.requestUrl = url.absoluteString
                print("Request URL: \(url.absoluteString)")
            }
        }
        .padding()
        .sheet(item: $recipeDetails) { details in
            RecipeDetailTestView(recipe: details)
        }
    }
}

struct RecipeDetailTestView: View {
    var recipe: RecipeInformation
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url)
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                Text(recipe.title ?? "No title")
                    .font(.largeTitle)
                    .padding()
                Text("Инструкции")
                    .font(.headline)
                    .padding([.top, .leading, .trailing])
                Text(recipe.instructions ?? "Нет инструкций")
                    .padding()
                
                Text("Ингредиенты")
                    .font(.headline)
                    .padding([.top, .leading, .trailing])
                ForEach(recipe.extendedIngredients ?? [], id: \.id) { ingredient in
                    HStack {
                        if let imageUrl = ingredient.image, let url = URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(imageUrl)") {
                            AsyncImage(url: url)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        Text("\(ingredient.original ?? "Нет данных")")
                            .padding([.leading, .trailing])
                    }
                    .padding(.vertical, 2)
                }
            }
        }
    }
}

#Preview {
    TestSearchView()
}

