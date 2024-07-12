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
        VStack {
            if selectedTab == .home {
                HomeView(appManager: appManager)
            } else if selectedTab == .bookmark {
                BookMarkView(appManager: appManager)
            }
                        
            CustomTabBarView(selectedTab: $selectedTab)
            
            /*
            CustomNavBarViewShape(isCheckHome: $isCheckHome,
                                  isCheckBookmark: $isCheckBookmark,
                                  isCheckBell: $isCheckBell,
                                  isCheckProfile: $isCheckProfile,
                                  index: $index)
            */
            
            /*
            CustomNavBarViewShape(isCheckHome: $isCheckHome,
                                  isCheckBookmark: $isCheckBookmark,
                                  isCheckBell: $isCheckBell,
                                  isCheckProfile: $isCheckProfile,
                                  index: $index)
                .offset(CGSize(width: 0.0, height: -40))
                .padding(.horizontal, 30)
                .background(CustomBox(angle: OffsetCustomBox.angle, radiusOne: OffsetCustomBox.radiusOne, radiusTwo: OffsetCustomBox.radiusTwo)
                    .frame(height: 150)
                    .background(.clear)
                    .foregroundStyle(.white)
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, y: -5))
                .overlay {
                    Button {
                        print("Round Action")
                    }   label: {
                        Image(systemName: "plus")
                            .font(.title.bold())
                    }
                    .frame(width: 70, height: 70)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(CGSize(width: 0.0, height: -60))
                }
            */
        }
    }
}

#Preview {
    RootView(appManager: RecipesManager())
}
