//
//  RootView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 11.07.2024.
//

import SwiftUI

struct RootView: View {
    
    @ObservedObject var appManager: RecipesManager
    @State var selectedTab: Tab = .home
    
    var body: some View {
        
        switch selectedTab {
        case .home:
            HomeView(appManager: appManager)
        case .bookmark:
            BookMarkView(appManager: appManager)
        case .bell:
            Spacer()
            EmptyView() // заглушка для экрана BellView
        case .profile:
            Spacer()
            EmptyView() // заглушка для экрана ProfileView
        case .plus:
            Spacer()
            EmptyView() // заглушка для экрана AddRecipeView
        }
        
        //MARK: - Custom TabBar
        CustomTabBarView(selectedTab: $selectedTab)
            .offset(CGSize(width: 0.0, height: -40))
            .padding(.horizontal, 30)
            .background(
                CustomBox(
                    angle: OffsetCustomBox.angle,
                    radiusOne: OffsetCustomBox.radiusOne,
                    radiusTwo: OffsetCustomBox.radiusTwo
                )
                .frame(height: 150)
                .background(.clear)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.1), radius: 10, y: -5)
            )
            .overlay {
                Button {
                    print("Round Action")
                } label: {
                    Image(systemName: "plus")
                        .font(.title.bold())
                }
                .frame(width: 70, height: 70)
                .background(Color.red)
                .clipShape(Circle())
                .offset(CGSize(width: 0.0, height: -60))
            }
        //: End Custom TabBar
    }
}

#Preview {
    RootView(appManager: RecipesManager())
}
