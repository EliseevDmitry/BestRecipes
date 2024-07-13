//
//  BookMarkView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 10.07.2024.
//

import SwiftUI

struct BookMarkView: View {
    @ObservedObject var appManager: RecipesManager
    var networkManager = NetworkManager.shared
    @State private var trendingItems: [Frame1View] = []
    @State private var isLoading = false
    
    var body: some View {
        NavigationView{
            VStack{
                HStack {
                    Text("Saved recipes")
                        .font(.custom(Poppins.bold, size: 24))
                    Spacer()
                }
                .padding(.horizontal, 20)
                ScrollView(.vertical, showsIndicators: false) {
                    //(spacing: 20)
                    LazyVStack {
                        ForEach(trendingItems, id: \.id) { item in
                            NavigationLink(destination: RecipeDetailView(appManager: appManager, recipeId: item.id)) {
                                item
                                    .padding(.horizontal)
                                    .padding(.bottom, 50)
                            }
                        }
                        
                    }
                    .frame(height: 200)
                }
                .padding(.bottom, 70)
                .padding(.top, 70)
            }
            .padding(.top, 50)
            .ignoresSafeArea(.all, edges: .all)
        }
        .task {
            loadBookmarkedRecipes()
        }
    }
    
    
    
    
    //По этим функциям идет утечка --------------------
    private func loadBookmarkedRecipes() {
        isLoading = true
        fetchFrames(for: appManager.bookMark.bookMarkSet.sorted()) { frames in
            DispatchQueue.main.async {
                self.isLoading = false
                self.trendingItems = frames
            }
        }
    }
    
    private func fetchFrames(for ids: [Int], completion: @escaping ([Frame1View]) -> Void) {
        let group = DispatchGroup()
        var frames: [Frame1View] = []
        for id in ids {
            group.enter()
            networkManager.fetchRecipeDetails(for: id) { result in
                switch result {
                case .success(let recipeDetails):
                    let frame = Frame1View(
                        appManager: appManager,
                        id: recipeDetails.id ?? 0,
                        foodFoto: recipeDetails.image ?? "no image",
                        title: recipeDetails.title ?? "no title",
                        cuisines: recipeDetails.cuisines ?? []
                    )
                    frames.append(frame)
                case .failure(let error):
                    print("Error fetching recipe details for id \(id): \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(frames)
        }
    }
    
    //По этим функциям идет утечка --------------------
}

#Preview {
    BookMarkView(appManager: RecipesManager())
}
