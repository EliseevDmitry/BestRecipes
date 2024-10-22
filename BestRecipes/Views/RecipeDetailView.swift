

import SwiftUI

struct RecipeDetailView: View {
    
    
    @ObservedObject var appManager: RecipesManager
    @Environment(\.dismiss) var dismiss
    
    @State private var recipeDetails: RecipeInformation?
    @State private var errorMessage: String?
    @State private var isLoading = false
    @State private var textTitle = ""
    @State private var showAlert = false
    
    var recipeId: Int?
    var cuisine: String?
    var networkManager = NetworkManager.shared
    var recipe: RecipeInformation?
    
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
                .padding(.bottom, 90)
            }
            .onAppear {
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
            .onDisappear{
                self.recipeDetails = nil
            }
            .padding(.horizontal, 10)
            .onAppear{
                if let id = recipeId {
                    appManager.addRecentData(id: id)
                }
            }
        }
        // в панели навигации: стрелка влево вместо кнопки Back и кнопка "...", вызывающая alert
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.primary)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "ellipsis")
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("- Разыгрался аппетит?"), message: Text("- Да, согласен даже перевести 100 рублей разработчикам!"))
        }
    }
}


#Preview {
    RecipeDetailView(appManager: RecipesManager(), recipeId: 640275)
}
