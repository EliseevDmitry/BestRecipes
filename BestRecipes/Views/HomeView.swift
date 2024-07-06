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
    var frameArr: [Frame1View] = [Frame1View(id: 1), Frame1View(id: 2), Frame1View(id: 3), Frame1View(id: 4), Frame1View(id: 5)]
    @State private var selectionCategory = "Breakfast"
    
    @State private var popularItems: [PopularItemView] = []
    @State private var errorMessage: String?
    
    var categories = ["Salad", "Breakfast", "Appetizer", "Noodle", "Lunch", "...", "jhjhj", "jjj"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // MARK: - Trending Section
                    HStack {
                        Text("Trending")
                        Image(systemName: "flame")
                        Spacer()
                        Text("See All")
                        Image(systemName: "arrow.right")
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(frameArr, id: \.self) { item in
                                NavigationLink(destination: RecipeDetailView()) {
                                    item
                                }
                            }
                        }
                    }
                    .padding(.leading, 20)
                    
                    // MARK: - Popular Categories Section
                    HStack {
                        Text("Popular Category")
                        Spacer()
                    }
                    .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(categories, id: \.self) { item in
                                TestBTN(title: item) {
                                    
                                    networkManager.fetchPopularCategory(for: item) { result in
                                        DispatchQueue.main.async {
                                            switch result {
                                            case .success(let response):
                                                self.popularItems = response.results.map { popularRecipe in
                                                    PopularItemView(
                                                        
                                                        foodFoto: popularRecipe.image ?? "no image",
                                                        title: popularRecipe.title ?? "no title",
                                                        time: "N/A", // Placeholder for time
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
                        LazyHStack(spacing: 20) {
                            ForEach(popularItems, id: \.self) { item in
                                NavigationLink(destination: RecipeDetailView()) {
                                    item
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20) // Changed padding from leading to horizontal
                }
            }
            .navigationTitle("Get Amazing recipes to cooking")
            .navigationBarTitleDisplayMode(.automatic)
        }

        CustomNavBarViewShape()
            .ignoresSafeArea()
    }
}

#Preview {
    HomeView(appManager: RecipesManager())
}
