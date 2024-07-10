import SwiftUI

struct RecipeCard: View {
    var id: Int
    var foodFoto: String
    var title: String
    var countIngredients : String = "9 Ingredients | 25 min"
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: foodFoto)) { phase in
                switch phase {
                case .empty:
                    Image(systemName: "wifi.slash")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                case .failure(_):
                    Image(systemName: "wifi.slash")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 340, height: 200) 
            .cornerRadius(25)
            .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 5) {
                RatingView()
                    .padding(.bottom, 80)
                    .padding(.leading, 0)
                
                VStack {
                    Text(title)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.leading, 5)
                
                VStack {
                    Text(countIngredients)
                        .foregroundColor(.white)
                        .font(.subheadline)
                }
                .padding(.leading, 5)
            }
            .padding()
        }
    }
}
#Preview {
    RecipeCard(id: 122, foodFoto: "", title: "")
}
