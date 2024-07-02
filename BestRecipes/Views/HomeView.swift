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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Home View!")
                .font(.custom(Poppins.Light, size: 30))
            Button("сбросить данные onboarding"){onboardingIsShow = false}
        }
        .padding()
    }
}

#Preview {
    HomeView(appManager: RecipesManager())
}
