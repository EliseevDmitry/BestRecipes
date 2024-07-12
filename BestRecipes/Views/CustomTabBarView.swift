//
//  CustomTabBarView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 12.07.2024.
//

import SwiftUI

enum Tab: Int {
    case home = 0
    case bookmark = 1
    case bell = 2
    case profile = 3
    case plus = 4
}

struct CustomTabBarView: View {

    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Button{
                // switch to HomeView
                selectedTab = .home
            } label: {
                Image(selectedTab != .home ? "home" : "homeRed")
            }
            
            Button{
                // switch to HomeView
                selectedTab = .bookmark
            } label: {
                Image(selectedTab != .bookmark ? "bookmark" : "bookmarkRed")
            }
            
            Button{
                // switch to HomeView
                selectedTab = .bell
            } label: {
                Image(selectedTab != .bell ? "bell" : "bellRed")
            }
            
            Button{
                // switch to HomeView
                selectedTab = .profile
            } label: {
                Image(selectedTab != .profile ? "profile" : "profileRed")
            }
            
            Button{
                // switch to HomeView
                selectedTab = .plus
            } label: {
                Text("Button-4")
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.home))
}
