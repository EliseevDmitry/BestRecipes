//
//  SeeAllTrendingView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 13.07.2024.
//

import SwiftUI

struct SeeAllTrendingView: View {
    @ObservedObject var appManager: RecipesManager
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @Binding var trendingItems: [Frame1View]

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
