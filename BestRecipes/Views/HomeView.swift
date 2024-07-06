//
//  ContentView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    
    @ObservedObject var appManager: RecipesManager
    @State private var searchResults: [SearchResultRecipe] = []
    var networkManager = NetworkManager.shared
    var frameArr: [Frame1View] = [Frame1View(id: 1), Frame1View(id: 2), Frame1View(id: 3), Frame1View(id: 4), Frame1View(id: 5)]
    @State private var selectionCatigory = "Breakfast"
    
    var categories = ["Salad", "Breakfast", "Appetizer", "Noodle", "Lunch", "...", "jhjhj", "jjj"]
    
    var body: some View {
        
        NavigationView{
            VStack{
                ScrollView{
                    VStack{
                        //searchView
                        HStack(){
                            Text("Trendind")
                            Image(systemName: "flame")
                            Spacer()
                            Text("See All")
                            Image(systemName: "arrow.right")
                        }
                        .padding(.horizontal, 20)
                        //выравнивание фрайма, и прокрутка влево без отступа от левого края экрана
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHStack(spacing: 20){
                                ForEach(frameArr, id: \.self){ item in
                                    NavigationLink(destination: RecipeDetailView()){
                                        item
                                    }
                                }
                            }
                            
                        }
                        .padding(.leading, 20)
                        HStack(){
                            Text("Popular Category")
                            Spacer()
                        }
                        //проблема №2 - кнопка должна тоглица и переключаться! Только ождна кнопка - может быть нажата!
                        ScrollView(.horizontal, showsIndicators: false){
                            LazyHStack {
                                ForEach(categories, id: \.self) { item in
                                    TestBTN(title: item, action: {})
                                        .foregroundStyle(.red)
                                    
                                }
                                
                            }
                            
                        }
                        .padding(.leading, 20)
                    }
                    
                }
                .navigationTitle("Get Amazing recipes to cooking")
                .navigationBarTitleDisplayMode(.automatic)
                //Проблема -  .ignoresSafeArea()
                CustomNavBarViewShape()
            }
            .ignoresSafeArea(.container, edges: .bottom)
        }

        
          
          
        
    }
}

#Preview {
    HomeView(appManager: RecipesManager())
}
