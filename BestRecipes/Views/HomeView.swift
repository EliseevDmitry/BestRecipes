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
    @State private var searchTerm = ""
    @State private var searchResults: [SearchResultRecipe] = []
    @State private var popularItems: [PopularItemView] = []
    @State private var trendingItems: [Frame1View] = []
    @State private var cuisinesItems: [Frame3View] = []
    @State private var errorMessage: String?
    @State private var selectionCategory = "Breakfast"
    
    var categories = [
        "Breakfast", "Main course", "Side dish", "Dessert", "Appetizer", "Salad",
        "Bread", "Soup", "Beverage", "Sauce", "Marinade",
        "Fingerfood", "Snack", "Drink"
    ]
    
    var cuisines = [
        "African", "Asian", "American", "British", "Cajun", "Caribbean",
        "Chinese", "Eastern European", "European", "French", "German",
        "Greek", "Indian", "Irish", "Italian", "Japanese", "Jewish",
        "Korean", "Latin American", "Mediterranean", "Mexican",
        "Middle Eastern", "Nordic", "Southern", "Spanish", "Thai", "Vietnamese"
    ]
    
    var networkManager = NetworkManager.shared
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        Text("Get Amazing recipes")
                            .font(.custom(Poppins.bold, size: 24))
                            .multilineTextAlignment(.center)
                        Text("to cooking")
                            .font(.custom(Poppins.bold, size: 24))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.leading, -90)
                    .background(.white)
                    
                    CustomSearchBar(searchTerm: $searchTerm)
                    
                    VStack(spacing: 20) {
                        // MARK: - Trending Section
                        HStack {
                            Text("Trending now 🔥")
                                .font(.custom(Poppins.bold, size: 20))
                            Spacer()
                            Text("See All")
                                .font(.custom(Poppins.bold, size: 14))
                                .foregroundStyle(.red)
                            Image(systemName: "arrow.right")
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        
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
                        .frame(maxHeight: .infinity)
                        // MARK: - Popular Categories Section
                        HStack {
                            Text("Popular Category")
                                .font(.custom(Poppins.bold, size: 20))
                            Spacer()
                        }
                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(categories, id: \.self) { item in
                                    PopularCategoryButton(title: item, selectedCategory: $selectionCategory) {
                                        networkManager.fetchPopularCategory(for: item) { result in
                                            DispatchQueue.main.async {
                                                switch result {
                                                case .success(let response):
                                                    self.popularItems = response.results.map { popularRecipe in
                                                        PopularItemView(
                                                            id: popularRecipe.id ?? 716429,
                                                            foodFoto: popularRecipe.image ?? "no image",
                                                            title: popularRecipe.title ?? "no title",
                                                            time: "N/A",
                                                            bookmarkIsOn: false,
                                                            cardWidth: 150
                                                        )
                                                    }
                                                    
                                                case .failure(let error):
                                                    self.errorMessage = error.localizedDescription
                                                    print("Error fetching popular category: \(error.localizedDescription)")
                                                }
                                            }
                                        }
                                    }
                                    .foregroundStyle(.red)
                                }
                            }
                        }
                        .padding(.leading, 20)
                        
                        // Display error message if any
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                        
                        // MARK: - Popular Items Section
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                ForEach(popularItems, id: \.self) { item in
                                    NavigationLink(destination: RecipeDetailView(recipeId: item.id)) {
                                        item
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .onAppear {
                        networkManager.fetchTrendingRecipes { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    self.trendingItems = response.results.map { element in Frame1View(
                                        id: element.id ?? 0,
                                        foodFoto: element.image ?? "",
                                        title: element.title ?? "")
                                    }
                                case .failure(let error):
                                    self.errorMessage = error.localizedDescription
                                    print("Error fetching trending recipes: \(error.localizedDescription)")
                                }
                            }
                        }
                        networkManager.fetchPopularCategory(for: selectionCategory) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    self.popularItems = response.results.map { popularRecipe in
                                        PopularItemView(
                                            id: popularRecipe.id ?? 716429,
                                            foodFoto: popularRecipe.image ?? "no image",
                                            title: popularRecipe.title ?? "no title",
                                            time: "N/A",
                                            bookmarkIsOn: false,
                                            cardWidth: 150
                                        )
                                    }
                                case .failure(let error):
                                    self.errorMessage = error.localizedDescription
                                    print("Error fetching popular category: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                    // MARK: - Cuisines Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(cuisines, id: \.self) { item in
                                NavigationLink(destination: RecipeDetailView(cuisine: item.uppercased())) {
                                    Frame3View(
                                        cuisineFoto: item.lowercased().replacingOccurrences(of: " ", with: ""),
                                        title: item)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
            }
            .padding(.top, 15)
            
            CustomNavBarViewShape()
                .searchable(text: $searchTerm, prompt: "Search recipes")
            
                
        }
        
        .ignoresSafeArea(.all, edges: .bottom)
    }
      
}

#Preview {
    HomeView(appManager: RecipesManager())
}
