
import SwiftUI

@main
struct BestRecipesApp: App {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    @StateObject var appManager = RecipesManager()
    
    var body: some Scene {
        WindowGroup {
            if onboardingIsShow {
               HomeView(appManager: appManager)
            } else {
               OnboardingStartView(appManager: appManager)
            }
        }
    }
}
