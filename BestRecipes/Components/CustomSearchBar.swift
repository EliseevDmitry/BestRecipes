// SearchBar.swift
// BestRecipes
//
// Created by Daniil Murzin on 07.07.2024.
//

import SwiftUI

struct CustomSearchBar: View {
    @ObservedObject var appManager: RecipesManager
    var networkManager = NetworkManager.shared
    @Binding var searchTerm: String
    @Binding var searchResults: [SearchResultRecipe]
    @Binding var showResultsSheet: Bool
    @State private var isSearching = false

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    performSearch()
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                }
                TextField("Search recipes", text: $searchTerm, onEditingChanged: { isEditing in
                    if !isEditing {
                        self.searchResults = []
                    }
                })
                .onChange(of: searchTerm) { newValue in
                    if newValue.isEmpty {
                        self.searchResults = []
                        self.showResultsSheet = false
                    }
                }
                .onSubmit {
                    performSearch()
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
            }
        }
    }
    
    private func performSearch() {
        guard !searchTerm.isEmpty else {
            return
        }
        isSearching = true
        networkManager.searchRecipe(for: searchTerm) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.searchResults = response.results
                    self.showResultsSheet = true
                case .failure(let error):
                    print("Error fetching search results: \(error.localizedDescription)")
                }
                isSearching = false
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchTerm = "Find your recipe"
    @State static var searchResults: [SearchResultRecipe] = []
    @State static var showResultsSheet = false

    static var previews: some View {
        CustomSearchBar(appManager: RecipesManager(), searchTerm: $searchTerm, searchResults: $searchResults, showResultsSheet: $showResultsSheet)
    }
}

