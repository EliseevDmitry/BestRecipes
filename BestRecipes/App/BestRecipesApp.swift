
import SwiftUI

@main
struct BestRecipesApp: App {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    @StateObject var appManager = RecipesManager()
    
    var body: some Scene {
        WindowGroup {
            if onboardingIsShow {
               RootView(appManager: appManager)
            } else {
               OnboardingStartView(appManager: appManager)
            }
        }
    }
}
