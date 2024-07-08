//  SearchBar.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 07.07.2024.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchTerm: String
    @State private var searchResults: [SearchResultRecipe] = []
    @State private var isSearching = false
    var networkManager = NetworkManager.shared

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                
                TextField("Search recipes", text: $searchTerm, onEditingChanged: { isEditing in
                    if !isEditing {
                        self.searchResults = []
                    }
                })
                .onChange(of: searchTerm) { newValue in
                    if !newValue.isEmpty {
                        isSearching = true
                        networkManager.searchRecipe(for: newValue) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    self.searchResults = response.results
                                case .failure(let error):
                                    print("Error fetching search results: \(error.localizedDescription)")
                                }
                                isSearching = false
                            }
                        }
                    } else {
                        self.searchResults = []
                    }
                }
                .frame(height: 44)
                .background(Color.white)
                .cornerRadius(10)
                .font(.custom(Poppins.regular, size: 14))
                .foregroundColor(.neutral30)
            }
            .frame(width: 360, height: 44)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.neutral25), lineWidth: 1)
            )
            .padding(.horizontal, 10)
            
            if isSearching {
                ProgressView()
                    .padding()
            } else if !searchResults.isEmpty {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(searchResults, id: \.id) { recipe in
                            NavigationLink(destination: RecipeDetailView(recipeId: recipe.id ?? 0)) {
                                Frame1View(id: recipe.id ?? 0, foodFoto: recipe.image ?? "", title: recipe.title ?? "")
                            }
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding(.horizontal)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchTerm = "Find your recipe"

    static var previews: some View {
        CustomSearchBar(searchTerm: $searchTerm)
    }
}


