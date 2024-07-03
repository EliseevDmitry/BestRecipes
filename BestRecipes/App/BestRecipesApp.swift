//
//  BestRecipesApp.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

@main
struct BestRecipesApp: App {
    @AppStorage("onboardingIsShow")
    var onboardingIsShow = false
    @StateObject var appManager = RecipesManager()
    var body: some Scene {
        WindowGroup {
            
//            if onboardingIsShow {
//                HomeView(appManager: appManager)
//            } else {
//                OnboardingView()
//            }
        }
    }
}
