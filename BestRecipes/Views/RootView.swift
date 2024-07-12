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
    
    /*
     @State private var isCheckHome = true
     @State private var isCheckBookmark = false
     @State private var isCheckBell = false
     @State private var isCheckProfile = false
     @State private var index = 0
     */
    
    var body: some View {
        switch selectedTab {
        case .home:
            HomeView(appManager: appManager)
        case .bookmark:
            BookMarkView(appManager: appManager)
        case .bell:
            EmptyView()
        case .profile:
            EmptyView()
        case .plus:
            EmptyView()
        }
        CustomTabBarView(selectedTab: $selectedTab)
            .offset(CGSize(width: 0.0, height: -40))
            .padding(.horizontal, 30)
            .background(CustomBox(angle: OffsetCustomBox.angle, radiusOne: OffsetCustomBox.radiusOne, radiusTwo: OffsetCustomBox.radiusTwo)
                .frame(height: 150)
                .background(.clear)
                .foregroundStyle(.white)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, y: -5)
            )
            .overlay(content: {
                Button {
                    print("Round Action")
                }
            label: {
                Image(systemName: "plus")
                    .font(.title.bold())
            }
            .frame(width: 70, height: 70)
            .background(Color.red)
            .clipShape(Circle())
            .offset(CGSize(width: 0.0, height: -60))
            })
    }
}

#Preview {
    RootView(appManager: RecipesManager())
}
