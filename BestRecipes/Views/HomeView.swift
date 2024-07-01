//
//  ContentView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboardingIsShow")
    var onboardingIsShow = false
    @ObservedObject var appManager: RecipesManager
    var body: some View {
        VStack {
            Text("Test")
                .font(.custom(Poppins.Black, size: 25))
            Text("Test")
                .font(.custom(Poppins.Bold, size: 25))
            Text("Test")
                .font(.custom(Poppins.ExtraBold, size: 25))
        }
        .ignoresSafeArea()
    }
}

#Preview {
    HomeView(appManager: RecipesManager())
}
