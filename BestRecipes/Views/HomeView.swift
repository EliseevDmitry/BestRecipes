
import SwiftUI

struct HomeView: View {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    
    @ObservedObject var appManager: RecipesManager
    @State private var searchTerm = ""
    @State private var searchResults: [SearchResultRecipe] = []
    @State private var popularItems: [PopularItemView] = []
    @State private var trendingItems: [Frame1View] = []
    @State private var cuisinesItems: [Frame3View] = []
    @State private var errorMessage: String?
    @State private var selectionCategory = "Breakfast"
    @State private var showSearchResults = false
    
    @State var selectedTab: Tab = .home

    
    var categories = [
        "Breakfast", "Dessert", "Appetizer", "Salad",
        "Bread", "Soup", "Beverage", "Sauce", "Marinade",
        "Fingerfood", "Snack", "Drink", "Main course", "Side dish"
    ]
    
    var cuisines = [
        "African", "Asian", "American", "British", "Cajun", "Caribbean",
        "Chinese", "Eastern European", "European", "French", "German",
        "Greek", "Indian", "Irish", "Italian", "Japanese", "Jewish",
        "Korean", "Latin American", "Mediterranean", "Mexican",
        "Middle Eastern", "Nordic", "Southern", "Spanish", "Thai", "Vietnamese"
    ]
    
    var networkManager = NetworkManager.shared
    
    
    @State private var isCheckHome = true
    @State private var isCheckBookmark = false
    @State private var isCheckBell = false
    @State private var isCheckProfile = false
    @State private var index = 0
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Get Amazing recipes")
                            .font(.custom(Poppins.bold, size: 24))
                            .multilineTextAlignment(.center)
                        Text("to cooking")
                            .font(.custom(Poppins.bold, size: 24))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.leading, -90)
                    .background(.white)
                    
                    CustomSearchBar(searchTerm: $searchTerm, searchResults: $searchResults, showResultsSheet: $showSearchResults, appManager: appManager)
                    
                    NavigationLink(destination: SearchResultsView(searchResults: $searchResults, searchTerm: $searchTerm, appManager: appManager), isActive: $showSearchResults) {
                        EmptyView()
                    }
                    
                    VStack(spacing: 20) {
                        // MARK: - Trending Section
                        HStack {
                            Text("Trending now 🔥")
                                .font(.custom(Poppins.bold, size: 20))
                            Spacer()
                            Text("See All")
                                .font(.custom(Poppins.bold, size: 14))
                                .foregroundStyle(.red)
                            Image(systemName: "arrow.right")
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 4) {
                                ForEach(trendingItems, id: \.id) { item in
                                    NavigationLink(destination: RecipeDetailView(recipeId: item.id)) {
                                        item
                                            .padding(.leading)
                                    }
                                }
                            }
                        }
                        .frame(maxHeight: .infinity)
                        
                        // MARK: - Popular Categories Section
                        HStack {
                            Text("Popular Category")
                                .font(.custom(Poppins.bold, size: 20))
                            Spacer()
                        }
                        .padding(.leading, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack {
                                ForEach(categories, id: \.self) { item in
                                    PopularCategoryButton(title: item, selectedCategory: $selectionCategory) {
                                        networkManager.fetchPopularCategory(for: item) { result in
                                            DispatchQueue.main.async {
                                                switch result {
                                                case .success(let response):
                                                    self.popularItems = response.results.map { popularRecipe in
                                                        PopularItemView(
                                                            appManager: appManager,
                                                            id: popularRecipe.id ?? 716429,
                                                            foodFoto: popularRecipe.image ?? "no image",
                                                            title: popularRecipe.title ?? "no title",
                                                            time: String(Int.random(in: 5...20)),
                                                            cardWidth: 150
                                                        )
                                                    }
                                                case .failure(let error):
                                                    self.errorMessage = error.localizedDescription
                                                    print("Error fetching popular category: \(error.localizedDescription)")
                                                }
                                            }
                                        }
                                    }
                                    .foregroundStyle(.red)
                                }
                            }
                        }
                        .padding(.leading, 20)
                        
                        // Display error message if any
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .padding()
                        }
                        
                        // MARK: - Popular Items Section
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 4) { //
                                ForEach(popularItems, id: \.id) { item in //елисеев
                                    NavigationLink(destination: RecipeDetailView(recipeId: item.id)) {
                                        item
                                            .frame(height: 294)
                                            .padding(.leading)
                                    }
                                }
                            }
                        }
                    }
                    .onAppear {
                        networkManager.fetchTrendingRecipes { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    self.trendingItems = response.results.map { element in Frame1View(
                                        appManager: appManager,
                                        id: element.id ?? 0,
                                        foodFoto: element.image ?? "",
                                        title: element.title ?? "")
                                    }
                                case .failure(let error):
                                    self.errorMessage = error.localizedDescription
                                    print("Error fetching trending recipes: \(error.localizedDescription)")
                                }
                            }
                        }
                        networkManager.fetchPopularCategory(for: selectionCategory) { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    self.popularItems = response.results.map { popularRecipe in
                                        
                                        PopularItemView(
                                            appManager: appManager,
                                            id: popularRecipe.id ?? 716429,
                                            foodFoto: popularRecipe.image ?? "no image",
                                            title: popularRecipe.title ?? "no title",
                                            time: String(Int.random(in: 5...50)),
                                            cardWidth: 150
                                        )
                                    }
                                case .failure(let error):
                                    self.errorMessage = error.localizedDescription
                                    print("Error fetching popular category: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                    
                    Text("jhkhk").font(.title).bold()
                    
                    
                    // MARK: - Cuisines Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 4) {
                            ForEach(cuisines, id: \.self) { item in
                                NavigationLink(destination: RecipeDetailView(cuisine: item.uppercased())) {
                                    Frame3View(
                                        cuisineFoto: item.lowercased().replacingOccurrences(of: " ", with: ""),
                                        title: item)
                                    .padding(.leading)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, 50)
            //.searchable(text: $searchTerm, prompt: "Search recipes")
           .ignoresSafeArea(.all, edges: .all)
        }
        .onAppear{
            appManager.loadBookMarkData()
        }
    }
    
    
}

#Preview {
    HomeView(appManager: RecipesManager())
}

