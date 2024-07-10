import Foundation

class RecipesManager: ObservableObject {
    var networkManager = NetworkManager.shared
    
    
//    @Published var onboarding = Onboarding(isShow: false)
//    
//    //сохранение данных о прохождении Onboardinga
//    func saveOnboardingData(){
//        let encoder = JSONEncoder()
//        if let data = try? encoder.encode(onboarding) {
//            UserDefaults.standard.set(data, forKey: "onboarding")
//        }
//    }
//    
//    //загрузка данных о прохождении Onboardinga
//    func loadOnboardingData(){
//        let decoder = JSONDecoder()
//        guard let data = UserDefaults.standard.data(forKey: "onboarding") else { return }
//        guard let loadData = try? decoder.decode(Onboarding.self, from: data) else {return}
//        onboarding.isShow = loadData.isShow
//    }

    
}
