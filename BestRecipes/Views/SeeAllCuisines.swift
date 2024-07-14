//
//  SeeAllCuisines.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 14.07.2024.
//

import SwiftUI

struct SeeAllCuisines: View {
    @ObservedObject var appManager: RecipesManager
    @Binding var cuisinesItems: [Frame3View]
    
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
                    LazyVStack {
                        ForEach(cuisinesItems, id: \.self) { item in
                            NavigationLink(destination: SearchCuisines(appManager: appManager, cuisines: item.title)) {
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

