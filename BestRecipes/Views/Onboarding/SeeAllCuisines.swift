//
//  SeeAllCuisines.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 14.07.2024.
//

import SwiftUI

struct SeeAllCuisines: View {
    @ObservedObject var appManager: RecipesManager
    var cuisinesItems: [String]
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
        
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("Популярные кухни мира")
                                .font(.custom(Poppins.bold, size: 24))
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 70)
                    
                    LazyVGrid(columns: columns) {
                        ForEach(cuisinesItems, id: \.self) { item in
                            NavigationLink(destination: SearchCuisines(appManager: appManager, cuisines: item)) {
                                Frame3View(
                                    cuisineFoto: item.lowercased().replacingOccurrences(of: " ", with: ""),
                                    title: item
                                )
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
