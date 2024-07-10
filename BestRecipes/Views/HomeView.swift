
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
    
    
    @State private var isCheckHome = false
    @State private var isCheckBookmark = false
    @State private var isCheckbell = false
    @State private var isCheckprofile = false
    
    var body: some View {
        VStack {
            NavigationView {
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
                    
                    CustomSearchBar(searchTerm: $searchTerm)
                    
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
                            LazyHStack(spacing: 20) {
                                ForEach(trendingItems, id: \.self) { item in
                                    NavigationLink(destination: RecipeDetailView(recipeId: item.id)) {
                                        item
                                            .padding(.leading)
                                    }
                                }
                            }
                        }
                        //                        .padding(.horizontal, 20)
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
                                                            id: popularRecipe.id ?? 716429,
                                                            foodFoto: popularRecipe.image ?? "no image",
                                                            title: popularRecipe.title ?? "no title",
                                                            time: String(Int.random(in: 5...20)),
                                                            bookmarkIsOn: false,
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
                                ForEach(popularItems, id: \.self) { item in
                                    NavigationLink(destination: RecipeDetailView(recipeId: item.id)) {
                                        item
                                            .frame(height: 294)
                                            .padding(.leading) // добавил, чтобы до начала прокрутки у группы карточек был отступ слева
                                    }
                                }
                            }
                        }
                        //                        .padding(.horizontal, 20) // убрал, чтобы группа карточек прокручивалась от края до края
                    }
                    .onAppear {
                        networkManager.fetchTrendingRecipes { result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let response):
                                    self.trendingItems = response.results.map { element in Frame1View(
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
                                            id: popularRecipe.id ?? 716429,
                                            foodFoto: popularRecipe.image ?? "no image",
                                            title: popularRecipe.title ?? "no title",
                                            time: String(Int.random(in: 5...50)),
                                            bookmarkIsOn: false,
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
                    // MARK: - Cuisines Section
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(cuisines, id: \.self) { item in
                                NavigationLink(destination: RecipeDetailView(cuisine: item.uppercased())) {
                                    Frame3View(
                                        cuisineFoto: item.lowercased().replacingOccurrences(of: " ", with: ""),
                                        title: item)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
            }
            .padding(.top, 15)
            CustomNavBarViewShape(isCheckHome: $isCheckHome, isCheckBookmark: $isCheckBookmark, isCheckbell: $isCheckbell, isCheckprofile: $isCheckprofile)
                .offset(CGSize(width: 0.0, height: -40))
                .padding(.horizontal, 20)
                .background(CustomBox(angle: OffsetCustomBox.angle, radiusOne: OffsetCustomBox.radiusOne, radiusTwo: OffsetCustomBox.radiusTwo)
                    .frame(height: 150)
                    .background(.clear)
                    .foregroundStyle(.white)
                    .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, y: -5)
                )
                .overlay(content: {
                    Button {
                        print("Round Action")
                    }
                label: {
                    Image(systemName: "plus")
                        .font(.title.bold())
                }
                .frame(width: 70, height: 70)
                .background(Color.red)
                .clipShape(Circle())
                .offset(CGSize(width: 0.0, height: -60))
                })
                .searchable(text: $searchTerm, prompt: "Search recipes")
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    
}

#Preview {
    HomeView(appManager: RecipesManager())
}
