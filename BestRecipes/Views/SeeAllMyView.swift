//
//  SeeAllMyView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 13.07.2024.
//
//<T: Codable>(_ file: String)->T 
import SwiftUI

struct SeeAllMyView: View {
    @ObservedObject var appManager: RecipesManager
    var networkManager = NetworkManager.shared
    @Binding private var anyView: [AnyHashable]
    @State private var isLoading = false
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        HStack{
                            Text("Saved recipes")
                                .font(.custom(Poppins.bold, size: 24))
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 70)
                    LazyVStack {
                        ForEach(anyView, id: \.self) { item in
                            NavigationLink(destination: RecipeDetailView(appManager: appManager, recipeId: item.id)) {
                                item
                                    .padding(.horizontal)
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                    .padding(.bottom, 80)
                }
            }
            .ignoresSafeArea(.all, edges: .all)
        }
        .task {
            loadBookmarkedRecipes()
        }
        .onDisappear{
            self.anyView = []
        }
    }

    private func loadBookmarkedRecipes() {
        isLoading = true
        fetchFrames(for: appManager.bookMark.bookMarkSet.sorted()) { frames in
            DispatchQueue.main.async {
                self.isLoading = false
                self.anyView = frames
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
}

#Preview {
    SeeAllMyView(appManager: RecipesManager())
}
