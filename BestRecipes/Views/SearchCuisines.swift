//
//  SearchCuisines.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 14.07.2024.
//

import SwiftUI

struct SearchCuisines: View {
    @ObservedObject var appManager: RecipesManager
    var networkManager = NetworkManager.shared
    @State private var searchResults: [SearchResultRecipe] = []
    //@Binding var trendingItems: [Frame1View]
    var cuisines: String
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @State private var errorMessage: String?
    @State private var isLoading = false
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    HStack{
                        Text("Trending now")
                            .font(.custom(Poppins.bold, size: 24))
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 100)
                LazyVStack {
                    ForEach(searchResults, id: \.id) { item in
                        NavigationLink(destination: RecipeDetailView(appManager: appManager, recipeId: item.id)) {
                            Frame1View(appManager: appManager, id: item.id ?? 1, foodFoto: item.image ?? "", title: item.title ?? "", cuisines: [cuisines])
                                .padding(.horizontal)
                                .padding(.bottom, 20)
                        }
                    }
                }
                .padding(.bottom, 80)
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .task {
            searchCuisines(cuisines: cuisines)
        }
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
    
    func searchCuisines(cuisines: String){
        networkManager.fetchCuisine(for: cuisines) { result in
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
}
