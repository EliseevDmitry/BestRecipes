

import SwiftUI

struct SearchResultsView: View {
    @Binding var searchResults: [SearchResultRecipe]
    @Binding var searchTerm: String
    @State private var showSearchResults = false
    @ObservedObject var appManager: RecipesManager
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showAlert = false
    
//    var searchResults: [SearchResultRecipe]
    
    var body: some View {
        VStack {
            ZStack {
                CustomSearchBar(searchTerm: $searchTerm, searchResults: $searchResults, showResultsSheet: $showSearchResults, appManager: appManager)
                
                if !searchTerm.isEmpty {
                    HStack {
                        Spacer()
                        Button(action: {
                            searchTerm = ""
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.black)
                                .padding(.trailing, 30)
                        }
                    }
                }
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 12) { 
                    ForEach(searchResults, id: \.id) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipeId: recipe.id ?? 0, appManager: appManager)) {
                            RecipeCard(id: recipe.id ?? 0,
                                       foodFoto: recipe.image ?? "",
                                       title: recipe.title ?? "")
                        }
                        .frame(width: 340, height: 200)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color.white)
        .padding(.horizontal)
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

struct SearchResultsView_Previews: PreviewProvider {
    @State static var searchResults = [
        SearchResultRecipe(id: 1, title: "Spaghetti Bolognese", image: "mockImage1", imageType: "jpg"),
        SearchResultRecipe(id: 1, title: "Spaghetti Bolognese", image: "mockImage2", imageType: "jpg")
        
    ]
    @State static var searchTerm = "Spaghetti"
    
    static var previews: some View {
        NavigationView {
            SearchResultsView(searchResults: $searchResults, searchTerm: $searchTerm, appManager: RecipesManager())
        }
    }
}



