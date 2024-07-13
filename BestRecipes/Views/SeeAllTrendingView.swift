//
//  SeeAllTrendingView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 13.07.2024.
//

import SwiftUI

struct SeeAllTrendingView: View {
    @ObservedObject var appManager: RecipesManager
    @Binding var trendingItems: [Frame1View]
    var body: some View {
        NavigationView{
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
                    .padding(.top, 70)
                    LazyVStack {
                        ForEach(trendingItems, id: \.id) { item in
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
    }
}
