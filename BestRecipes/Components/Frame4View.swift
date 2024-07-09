
import SwiftUI
struct RecipeCard: View {
    var recipeName: String = "How to make yam \n& vegetable sauce at home"
    var countIngredients : String = "9 Ingredients | 25 min"
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("african")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
                .clipped()

            VStack(alignment: .leading, spacing: 5) {
                    RatingView()
                
                  .padding(.bottom, 95)
                  .padding(.leading, 0)
                VStack{
                    
                    Text(recipeName)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                    
                }.padding(.leading, 5)
                
                VStack
                {
                    Text(countIngredients)
                        .foregroundColor(.white)
                        .font(.subheadline)
                }.padding(.leading, 5)
                
                
            }
            .padding()

        }
        .cornerRadius(25)
        .padding()
        .shadow(radius: 5)
    }
}


#Preview {
    RecipeCard()
}
