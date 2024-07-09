//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI




struct RecipeDetailView: View {
    
    var recipeId: Int?
    var cuisine: String?
    var networkManager = NetworkManager.shared
    var recipe: RecipeInformation?
    @State private var recipeDetails: RecipeInformation?
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var textTitle = ""
    
    var body: some View {
        VStack {
            ScrollView (showsIndicators: false){
                VStack(alignment: .leading) {
                    if let imageUrl = recipeDetails?.image, let url = URL(string: imageUrl) {
                        Text(recipeDetails?.title ?? "No title")
                            .font(.largeTitle)
                            .padding()
                        
                        AsyncImage(url: url){image in
                            image
                                .image?.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 300)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        Text("Instructions")
                            .font(.title)
                            .padding([.top, .leading, .trailing])
                        
                        let html = recipeDetails?.instructions ?? "Нет инструкций"
                        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil),
                           let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
                            Text(attributedString)
                                .padding()
                        } else {
                            Text(html)
                                .padding()
                        }
                        HStack {
                            Text("Ingredients")
                                .font(.headline).bold()
                           // .padding([.top, .leading, .trailing])
                            Spacer()
                            if let count = recipeDetails?.extendedIngredients?.count{
                                Text("\(count) Items")
                                    .foregroundStyle(.neutral40)
                            } else {
                                Text("0 Items")
                            }
                        }
                        .padding(.horizontal, 10)
                        ForEach(recipeDetails?.extendedIngredients ?? [], id: \.id) { ingredient in
                            IngredientsView(titleString: "\(ingredient.original ?? "Нет данных")", ingredientImage: ingredient.image)
                        }
                    }
                }
            }
            .task {
                if let id = recipeId {
                    print(id)
                    isLoading = true
                    networkManager.fetchRecipeDetails(for: id) { result in
                        DispatchQueue.main.async {
                            isLoading = false
                            switch result {
                            case .success(let response):
                                self.recipeDetails = response
                            case .failure(let error):
                                self.errorMessage = "Error: \(error.localizedDescription)"
                                print("Error: \(error)")
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
        }
    }
}


#Preview {
    RecipeDetailView(recipeId: 640275)
}
