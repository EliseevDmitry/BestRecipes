
import SwiftUI

struct HomeView: View {
    @AppStorage("onboardingIsShow") var onboardingIsShow = false
    
    @ObservedObject var appManager: RecipesManager
    @State private var searchTerm = ""
    @State private var searchResults: [SearchResultRecipe] = []
    @State private var popularItems: [PopularItemView] = []
    @State private var trendingItems: [Frame1View] = []
    @State private var recentItems: [Frame2] = []
    @State private var cuisinesItems: [Frame3View] = []
    @State private var errorMessage: String?
    @State private var selectionCategory = "Breakfast"
    @State private var showSearchResults = false
    
    var networkManager = NetworkManager.shared
    
    @State private var isCheckHome = false
    @State private var isCheckBookmark = false
    @State private var isCheckbell = false
    @State private var isCheckprofile = false
    @State private var isLoading = false
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
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 4) {
                                ForEach(trendingItems, id: \.id) { item in
                                    NavigationLink(destination: RecipeDetailView(recipeId: item.id, appManager: appManager)) {
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
                                    NavigationLink(destination: RecipeDetailView(recipeId: item.id, appManager: appManager)) {
                                        item
                                            .frame(height: 294)
                                            .padding(.leading)
                                    }
                                }
                            }
                        }
   
                    }
                    .onAppear {
                        
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
                                            time: Int.random(in: 5...50)
                                        )
                                    }
                                case .failure(let error):
                                    self.errorMessage = error.localizedDescription
                                    print("Error fetching popular category: \(error.localizedDescription)")
                                }
                            }
                        }
                        
                        
                        
                        fetchTrendingRecipesWithDetails()
                        fetchPopularCategoryWithDetails(for: selectionCategory)
                        loadRecentRecipes()
                    }
                    //-------------
                    // MARK: - Recent recipe Section
//                    HStack {
//                        Text("Recent recipe")
//                            .font(.custom(Poppins.bold, size: 20))
//                        Spacer()
//                        Button{
//
//                        }label: {
//                            Text("See All")
//                                .font(.custom(Poppins.bold, size: 14))
//                                .foregroundStyle(.red)
//                            Image(systemName: "arrow.right")
//                        }
//                    }
//                   .padding(.horizontal, 20)
//
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        LazyHStack(spacing: 4) {
//                            ForEach(recentItems, id: \.id) { item in
//                                NavigationLink(destination: RecipeDetailView(recipeId: item.id, appManager: appManager)) {
//                                    item
//                                        .padding(.leading)
//                                }
//                            }
//                        }
//                    }
//                    .frame(maxHeight: .infinity)
                    //---------------
                    
                    //-------------
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
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 4) {
                            ForEach(recentItems, id: \.id) { item in
                                NavigationLink(destination: RecipeDetailView(recipeId: item.id, appManager: appManager)) {
                                    item
                                        .padding(.leading)
                                }
                            }
                        }
//                        .frame(maxHeight: .infinity)
                    }
//                    .frame(maxHeight: .infinity)
                    //---------------
                    
                    // MARK: - Cuisines Section
                    HStack {
                        Text("Popular creators")
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
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(DataConstants.cuisines, id: \.self) { item in
                                NavigationLink(destination: RecipeDetailView(cuisine: item.uppercased(), appManager: appManager)) {
                                    Frame3View(
                                        cuisineFoto: item.lowercased().replacingOccurrences(of: " ", with: ""),
                                        title: item)
                                    .padding(.leading)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 30)
                    
                    // MARK: - Video Section
                    VideoView()
                      //  .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
//                CustomNavBarViewShape(isCheckHome: $isCheckHome, isCheckBookmark: $isCheckBookmark, isCheckbell: $isCheckbell, isCheckprofile: $isCheckprofile)
//                    .offset(CGSize(width: 0.0, height: -40))
//                    .padding(.horizontal, 30)
//                    .background(CustomBox(angle: OffsetCustomBox.angle, radiusOne: OffsetCustomBox.radiusOne, radiusTwo: OffsetCustomBox.radiusTwo)
//                        .frame(height: 150)
//                        .background(.clear)
//                        .foregroundStyle(.white)
//                        .shadow(color: .black.opacity(0.1), radius: 10, y: -5)
//                    )
//                    .overlay(content: {
//                        Button {
//                            print("Round Action")
//                        }
//                    label: {
//                        Image(systemName: "plus")
//                            .font(.title.bold())
//                    }
//                    .frame(width: 70, height: 70)
//                    .background(Color.red)
//                    .clipShape(Circle())
//                    .offset(CGSize(width: 0.0, height: -60))
//                    })
            }
            .padding(.top, 50)
            .ignoresSafeArea(.all, edges: .all)
        }
        .onAppear{
            appManager.loadBookMarkData()
            appManager.loadRecentData()
        }
    }
    
    
    private func fetchTrendingRecipesWithDetails() {
        networkManager.fetchTrendingRecipes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let group = DispatchGroup()
                    var newTrendingItems: [Frame1View] = []
                    for recipe in response.results {
                        guard let id = recipe.id else { continue }
                        group.enter()
                        networkManager.fetchRecipeDetails(for: id) { result in
                            switch result {
                            case .success(let recipeDetails):
                                let item = Frame1View(
                                    appManager: appManager,
                                    id: recipeDetails.id ?? 0,
                                    foodFoto: recipeDetails.image ?? "no image",
                                    title: recipeDetails.title ?? "no title",
                                    cuisines: recipeDetails.cuisines ?? []
                                )
                                newTrendingItems.append(item)
                            case .failure(let error):
                                print("Error fetching recipe details: \(error.localizedDescription)")
                            }
                            group.leave()
                        }
                    }
                    group.notify(queue: .main) {
                        self.trendingItems = newTrendingItems
                    }
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
                    let group = DispatchGroup()
                    var newPopularItems: [PopularItemView] = []
                    
                    for recipe in response.results {
                        guard let id = recipe.id else { continue }
                        
                        group.enter()
                        networkManager.fetchRecipeDetails(for: id) { result in
                            switch result {
                            case .success(let recipeDetails):
                                let item = PopularItemView(
                                    appManager: appManager,
                                    id: recipeDetails.id ?? 0,
                                    foodFoto: recipeDetails.image ?? "no image",
                                    title: recipeDetails.title ?? "no title",
                                    time: recipeDetails.readyInMinutes ?? 0
                                    //cardWidth: 150
                                )
                                newPopularItems.append(item)
                            case .failure(let error):
                                print("Error fetching recipe details: \(error.localizedDescription)")
                            }
                            group.leave()
                        }
                    }
                    
                    group.notify(queue: .main) {
                        self.popularItems = newPopularItems
                    }
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
    
    
    //загрузка массива рецептов
    private func fetchFrames(for ids: [Int], completion: @escaping ([Frame2]) -> Void) {
        let group = DispatchGroup()
        var frames: [Frame2] = []
        for id in ids {
            group.enter()
            networkManager.fetchRecipeDetails(for: id) { result in
                switch result {
                case .success(let recipeDetails):
                    let frame = Frame2(
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

