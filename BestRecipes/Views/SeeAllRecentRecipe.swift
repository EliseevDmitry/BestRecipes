//
//  SeeAllRecentRecipe.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 13.07.2024.
//

import SwiftUI

struct SeeAllRecentRecipe: View {
    @ObservedObject var appManager: RecipesManager
    @Binding var recentItems: [Frame2View]
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        HStack{
                            Text("Recent recipe")
                                .font(.custom(Poppins.bold, size: 24))
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 70)
                    LazyVStack {
                        ForEach(recentItems, id: \.id) { item in
                            NavigationLink(destination: RecipeDetailView(appManager: appManager, recipeId: item.id)) {
                                Frame1View(appManager: appManager, id: item.id, foodFoto: item.foodFoto, title: item.title, cuisines: item.cuisines)
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
    }
}

