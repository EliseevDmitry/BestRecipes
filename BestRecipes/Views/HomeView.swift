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
    
    var popularItems: [PopularItemView] = [
        PopularItemView(
            foodFoto: "mockImage1",
            title: "Chicken and Vegetable wrap",
            time: "5 Mins",
            bookmarkIsOn: true,
            cardWidth: 150
        ),
        PopularItemView(
            foodFoto: "mockImage1",
            title: "Cucumber only",
            time: "10 Mins",
            bookmarkIsOn: false,
            cardWidth: 150
        ),
        PopularItemView(
            foodFoto: "mockImage1",
            title: "Chicken without Vegetables",
            time: "15 Mins",
            bookmarkIsOn: true,
            cardWidth: 150
        ),
        PopularItemView(
            foodFoto: "mockImage1",
            title: "Vegetable only",
            time: "2 Mins",
            bookmarkIsOn: false,
            cardWidth: 150
        ),
    ]
    
    // массив модели (вначале пустой)
    @State private var searchResultRecipes: [SearchResultRecipe] = []
    
    var categories = ["Salad", "Breakfast", "Appetizer", "Noodle", "Lunch", "...", "jhjhj", "jjj"]
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    // ================================
                    // MARK: - начало блока searchView
                    
                    // ================================
                    HStack(){
                        Text("Trendind")
                        Image(systemName: "flame")
                        Spacer()
                        Text("See All")
                        Image(systemName: "arrow.right")
                    }
                    .padding(.horizontal, 20)
                    // TODO: выравнивание фрейма, и прокрутка влево без отступа от левого края экрана
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
                    
                    // =================================
                    // MARK: - начало блока Popular Categories: 1. название блока, 2. кнопки выбора категории, 3. карточки с популярными блюдами - [PopularItemView]
                    // 1. название блока
                    HStack(){
                        Text("Popular Category")
                        Spacer()
                    }
                    .padding()
                    
                    // 2. кнопки выбора категории
                    // TODO: проблема №2 - каждая кнопка в этой группе должна менять состояние (нажатая - красный текст на светлом фоне, ненажатая - белый текст на красном фоне); по умолчанию одна кнопка должна быть нажата; нажатие другой кнопки должно делать ее нажатой и ненажатыми все остальные; нажатая кнопка должна определять отображаемую коллекцию карточек - [PopularItemView]
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack {
                            ForEach(categories, id: \.self) { item in
                                TestBTN(title: item, action: {
                                    networkManager.fetchPopularCategory(for: item.title) { result in
                                        DispatchQueue.main.async {
                                            switch result {
                                            case .success(let response):
                                                self.searchResultRecipes = response.result
                                            case .error:
                                                print("Error")
                                            }
                                        }
                                    }
                                })
                                    .foregroundStyle(.red)
                            }
                        }
                    }
                    .padding(.leading, 20)
                    
                    // 3. карточки с популярными блюдами - [PopularItemView]
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(spacing: 20){
                            ForEach(popularItems, id: \.self){ item in
                                NavigationLink(destination: RecipeDetailView()) {
                                    item
                                }
                            }
                        }
                    }
                    .padding(.leading, 20)
                    
                    
                    // ===================================
                }
            }
            .navigationTitle("Get Amazing recipes to cooking")
            .navigationBarTitleDisplayMode(.automatic)
            
            
        }

        //Проблема -  .ignoresSafeArea()
        CustomNavBarViewShape()
            .ignoresSafeArea()
          
        
    }
}

#Preview {
    HomeView(appManager: RecipesManager())
}
