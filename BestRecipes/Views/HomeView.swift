
import SwiftUI

struct HomeView: View {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    @ObservedObject var appManager: RecipesManager
    var networkManager = NetworkManager.shared
    @State private var searchTerm = ""
    @State private var searchResults: [SearchResultRecipe] = []
    @State private var popularItems: [PopularItemView] = []
    @State private var trendingItems: [Frame1View] = []
    @State private var recentItems: [Frame2View] = []
    @State private var cuisinesItems: [Frame3View] = []
    @State private var errorMessage: String?
    @State private var selectionCategory = "Breakfast"
    @State private var showSearchResults = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    // MARK: - Title multiline
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
                    
                    // MARK: - Custom SearchBar
                    CustomSearchBar(appManager: appManager, searchTerm: $searchTerm, searchResults: $searchResults, showResultsSheet: $showSearchResults)
                    NavigationLink(destination: SearchResultsView(appManager: appManager, searchResults: $searchResults, searchTerm: $searchTerm), isActive: $showSearchResults) {
                        EmptyView()
                    }
                    
                    // MARK: - Trending Section
                    HStack {
                        Text("Trending now 🔥")
                            .font(.custom(Poppins.bold, size: 20))
                        Spacer()
                        Button{
                            
                        }label: {
                            Text("See All")
                                .font(.custom(Poppins.bold, size: 14))
                                .foregroundStyle(.red)
                            Image(systemName: "arrow.right")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    //: HStack
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 4) {
                            ForEach(trendingItems, id: \.id) { item in
                                NavigationLink(destination: RecipeDetailView(appManager: appManager, recipeId: item.id)) {
                                    item
                                        .frame(width: 280)
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
                    //: HStack
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(DataConstants.categories, id: \.self) { item in
                                PopularCategoryButton(title: item, selectedCategory: $selectionCategory) {
                                    fetchPopularCategoryWithDetails(for: item)
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
                            ForEach(popularItems, id: \.id) { item in
                                NavigationLink(destination: RecipeDetailView(appManager: appManager, recipeId: item.id)) {
                                    item
                                        .frame(width: 150, height: 234)
                                        .padding(.leading)
                                }
                            }
                        }
                    }//: ScrollView
                    
                    // MARK: - Recent recipe Section
                    HStack {
                        Text("Recent recipe")
                            .font(.custom(Poppins.bold, size: 20))
                        Spacer()
                        Button{
                            
                        }label: {
                            Text("See All")
                                .font(.custom(Poppins.bold, size: 14))
                                .foregroundStyle(.red)
                            Image(systemName: "arrow.right")
                        }
                    }
                    .padding(.horizontal, 20)
                    //: HStack
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 4) {
                            ForEach(recentItems, id: \.id) { item in
                                NavigationLink(destination: RecipeDetailView(appManager: appManager, recipeId: item.id)) {
                                    item
                                        .padding(.leading)
                                }
                            }
                        }
                    }//: ScrollView
                    
                    // MARK: - Cuisines Section
                    HStack {
                        Text("Popular cuisines")
                            .font(.custom(Poppins.bold, size: 20))
                        Spacer()
                        Button{
                            
                        }label: {
                            Text("See All")
                                .font(.custom(Poppins.bold, size: 14))
                                .foregroundStyle(.red)
                            Image(systemName: "arrow.right")
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    //: HStack
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(DataConstants.cuisines, id: \.self) { item in
                                NavigationLink(destination: RecipeDetailView(appManager: appManager, cuisine: item.uppercased())) {
                                    Frame3View(
                                        cuisineFoto: item.lowercased().replacingOccurrences(of: " ", with: ""),
                                        title: item)
                                    .padding(.leading)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 30)
                    //: ScrollView
                    
                    // MARK: - Video Section
                    HStack {
                        Text("Video recipe")
                            .font(.custom(Poppins.bold, size: 20))
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    //: HStack
                    VideoView()
                        .padding(.bottom, 100)
                }
                
            }
            .padding(.top, 50)
            .ignoresSafeArea(.all, edges: .all)
        }
        .onAppear{
            appManager.loadBookMarkData()
            appManager.loadRecentData()
        }
        .task {
            fetchTrendingRecipesWithDetails()
            fetchPopularCategoryWithDetails(for: selectionCategory)
            loadRecentRecipes()
        }
    }
    
    private func fetchTrendingRecipesWithDetails() {
        networkManager.fetchTrendingRecipes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.trendingItems = response.results.map({ result in
                        Frame1View(
                            appManager:appManager,
                            id: result.id ?? 716276,
                            foodFoto: result.image!,
                            title: result.title ?? "No data from model",
                            cuisines: result.cuisines ?? DataConstants.cuisines)
                    })
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching trending recipes: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func fetchPopularCategoryWithDetails(for category: String) {
        networkManager.fetchPopularCategory(for: category) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.popularItems = response.results.map({ result in
                        PopularItemView(
                            appManager: appManager,
                            id: result.id ?? 716276,
                            foodFoto: result.image!,
                            title: result.title ?? "No data from model",
                            time: result.readyInMinutes ?? Int.random(in: 1...30))
                    })
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching popular category: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func loadRecentRecipes() {
        isLoading = true
        fetchFrames(for: appManager.recentItem.item.reversed()) { frames in
            DispatchQueue.main.async {
                self.isLoading = false
                self.recentItems = frames
            }
        }
    }
    
    private func fetchFrames(for ids: [Int], completion: @escaping ([Frame2View]) -> Void) {
        let group = DispatchGroup()
        var frames: [Frame2View] = []
        for id in ids {
            group.enter()
            networkManager.fetchRecipeDetails(for: id) { result in
                switch result {
                case .success(let recipeDetails):
                    let frame = Frame2View(
                        appManager: appManager,
                        id: recipeDetails.id ?? 0,
                        foodFoto: recipeDetails.image ?? "no image",
                        title: recipeDetails.title ?? "no title",
                        cuisines: recipeDetails.cuisines ?? []
                    )
                    frames.append(frame)
                case .failure(let error):
                    print("Error fetching recipe details for id \(id): \(error.localizedDescription)")
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(frames)
        }
    }
}

#Preview {
    HomeView(appManager: RecipesManager())
}

