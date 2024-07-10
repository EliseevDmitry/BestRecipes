
import SwiftUI

@main
struct BestRecipesApp: App {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    
    @StateObject var appManager = RecipesManager()
    
    var body: some Scene {
        WindowGroup {
           // VideoView()
            
            if onboardingIsShow {
              // HomeView(appManager: appManager)
                OnboardingStartView(appManager: appManager)

               
            } else {
               OnboardingStartView(appManager: appManager)
            }
        }
    }
}
