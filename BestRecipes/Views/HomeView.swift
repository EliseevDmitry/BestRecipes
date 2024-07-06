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
    @State private var popularItems: [PopularItemView] = []
    @State private var frameArr: [Frame1View] = []
    @State private var cuisinesArray: [Frame3View] = []
    @State private var errorMessage: String?
    @State private var selectionCategory = "Breakfast"
    
    var cuisines = ["african", "asian", "american", "british"]
    var networkManager = NetworkManager.shared
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
                    .onAppear {
                        networkManager.fetchTrendingRecipes { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    self.frameArr = response.results.map { element in Frame1View(
                                        id: element.id ?? 0,
                                        foodFoto: element.image ?? "",
                                        title: element.title ?? "")
                                        
                                    }
                                    
                                case .failure(let error):
                                    self.errorMessage = error.localizedDescription
                                    print("Error fetching popular category: \(error.localizedDescription)")
                                }
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
                // MARK: - Popular Items Section
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(cuisines, id: \.self) { item in
                            NavigationLink(destination: RecipeDetailView()) {
                                Frame3View(
                                    cuisineFoto: item,
                                    title: item)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20) // Changed padding from leading to horizontal
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
