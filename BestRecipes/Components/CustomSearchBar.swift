
import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchTerm: String
    @State private var searchResults: [SearchResultRecipe] = []
    @State private var isSearching = false
    @State private var showResultsSheet = false
    var networkManager = NetworkManager.shared

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    performSearch()
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                }

                TextField("Search recipes", text: $searchTerm, onEditingChanged: { isEditing in
                    if !isEditing {
                        self.searchResults = []
                        
                    }
                })
                .onChange(of: searchTerm) { newValue in
                    if newValue.isEmpty {
                        self.searchResults = []
                        self.showResultsSheet = false
                    }
                }
                .onSubmit {
                    performSearch()
                }
                .frame(height: 44)
                .background(Color.white)
                .cornerRadius(10)
                .font(.custom(Poppins.regular, size: 14))
                .foregroundColor(.neutral30)
                
                Button(action: {
                    performSearch()
                }) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .padding(.trailing, 10)
                }
            }
            .frame(width: 360, height: 44)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(.neutral25), lineWidth: 1)
            )
            .padding(.horizontal, 10)
            
            if isSearching {
                ProgressView()
                    .padding()
            }
        }
        .sheet(isPresented: $showResultsSheet) {
            SearchResultsView(searchResults: searchResults)
        }
    }
    
    private func performSearch() {
        guard !searchTerm.isEmpty else {
            return
        }
        isSearching = true
        networkManager.searchRecipe(for: searchTerm) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.searchResults = response.results
                    self.showResultsSheet = true
                case .failure(let error):
                    print("Error fetching search results: \(error.localizedDescription)")
                }
                isSearching = false
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchTerm = "Find your recipe"

    static var previews: some View {
        CustomSearchBar(searchTerm: $searchTerm)
    }
}
