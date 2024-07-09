import SwiftUI

struct MyRecipeItemView: View {
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {
                VStack(alignment: .leading) {
                    
                    ForEach(0..<3) { _ in
                        RecipeCardView()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Trending now")
       
    }
}




struct RecipeCardView: View {
    @State private var isStarred : Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            Image("mockImage1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
                .overlay(
                    VStack {
                    Spacer()
                      
                        
                            HStack {
                                Spacer()
                                BookMark()
                            }
                            .position(CGPoint(x: 175.0, y: 15.0))
                           
                        
                        
                        HStack
                        {
                            RatingView()
                        }
                        
                        .position(CGPoint(x: 45.0, y: -40.0))
                       
                        
                        HStack
                        {
                          TimeView()
                        }
                        .position(CGPoint(x: 335.0, y: 20.0))
                    
                    }
                        
                )
            .padding(.horizontal)
            .padding(.top, 5)
            
            Text("How to make shawarma at home")
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 5)
     
            
            HStack {
                Image("mockAvatar")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .clipShape(Circle())
                Text("By Zeelicious Foods")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.bottom, 20)
    }
}


#Preview
{
    MyRecipeItemView()
}
