//
//  SeeAllCuisines.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 14.07.2024.
//

import SwiftUI

struct SeeAllCuisines: View {
    @ObservedObject var appManager: RecipesManager
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    var cuisinesItems: [String]
    var columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Text("World cuisines")
                                .font(.custom(Poppins.bold, size: 24))
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 100)
                    HStack{
                        //костыли
                        Spacer()
                        Spacer()
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
        }



#Preview {
    SeeAllCuisines(appManager: RecipesManager(), cuisinesItems: DataConstants.cuisines)
}
