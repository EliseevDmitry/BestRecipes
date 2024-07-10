//
//  SearchResultView.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 08.07.2024.
//

import SwiftUI

struct SearchResultsView: View {
    @Binding var searchResults: [SearchResultRecipe]
    @Binding var searchTerm: String
    @State private var showSearchResults = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ZStack {
                CustomSearchBar(searchTerm: $searchTerm, searchResults: $searchResults, showResultsSheet: $showSearchResults)
                
                if !searchTerm.isEmpty {
                    HStack {
                        Spacer()
                        Button(action: {
                            searchTerm = ""
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(.trailing, 30)
                        }
                    }
                }
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 12) { 
                    ForEach(searchResults, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipeId: recipe.id ?? 0)) {
                            RecipeCard(id: recipe.id ?? 0,
                                       foodFoto: recipe.image ?? "",
                                       title: recipe.title ?? "")
                        }
                        .frame(width: 340, height: 200)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.white)
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
    }
}

struct SearchResultsView_Previews: PreviewProvider {
    @State static var searchResults = [
        SearchResultRecipe(id: 1, title: "Spaghetti Bolognese", image: "mockImage1", imageType: "jpg"),
        SearchResultRecipe(id: 1, title: "Spaghetti Bolognese", image: "mockImage2", imageType: "jpg")
        
    ]
    @State static var searchTerm = "Spaghetti"
    
    static var previews: some View {
        NavigationView {
            SearchResultsView(searchResults: $searchResults, searchTerm: $searchTerm)
        }
    }
}

    

