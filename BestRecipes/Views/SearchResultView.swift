

import SwiftUI

struct SearchResultsView: View {
    @ObservedObject var appManager: RecipesManager
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    @Binding var searchResults: [SearchResultRecipe]
    @Binding var searchTerm: String
    @State private var showSearchResults = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            ZStack {
                CustomSearchBar(appManager: appManager, searchTerm: $searchTerm, searchResults: $searchResults, showResultsSheet: $showSearchResults)
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
                        NavigationLink(destination: RecipeDetailView(appManager: appManager, recipeId: recipe.id ?? 0)) {
                            RecipeCard(id: recipe.id ?? 0,
                                       foodFoto: recipe.image ?? "",
                                       title: recipe.title ?? "")
                        }
                        .frame(width: 340, height: 200)
                    }
                }
                .padding(.horizontal)
            }//: ScrollView
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


//MARK: - Preview
struct SearchResultsView_Previews: PreviewProvider {
    @State static var searchResults = [
        SearchResultRecipe(id: 1, title: "Spaghetti Bolognese", image: "mockImage1", imageType: "jpg", cuisines: DataConstants.cuisines, readyInMinutes: 5),
        SearchResultRecipe(id: 1, title: "Spaghetti Bolognese", image: "mockImage2", imageType: "jpg", cuisines: DataConstants.cuisines, readyInMinutes: 5)
        
    ]
    @State static var searchTerm = "Spaghetti"
    
    static var previews: some View {
        NavigationView {
            SearchResultsView(appManager: RecipesManager(), searchResults: $searchResults, searchTerm: $searchTerm)
        }
    }
}



