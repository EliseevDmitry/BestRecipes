//
//  SearchResultView.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 08.07.2024.
//

import SwiftUI

struct SearchResultsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    
    var searchResults: [SearchResultRecipe]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(searchResults, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipeId: recipe.id ?? 0)) {
                            Frame1View(id: recipe.id ?? 0, foodFoto: recipe.image ?? "", title: recipe.title ?? "")
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Search Results")
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal)
            // в панели навигации: стрелка влево вместо кнопки Back и кнопка "...", вызывающая alert
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.primary)
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAlert = true
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("- Разыгрался аппетит?"), message: Text("- Да, согласен даже перевести 100 рублей разработчикам!"))
            }
        }
    }
}
