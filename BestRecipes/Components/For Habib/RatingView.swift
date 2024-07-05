import SwiftUI

struct RatingView: View {
    @State private var isStarred: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                isStarred.toggle()
            }) {
                Image(systemName: isStarred ? "star.fill" : "star")
                    .foregroundColor(isStarred ? .yellow : .black)
            }
            Text("5,0")
                .foregroundColor(.white)
                .font(.headline)
        }
        .padding(10)
        .background(Color.black.opacity(0.3))
        .cornerRadius(13)
    }
}


struct TimeView : View {
    var target = 15
    
    var body: some View {
        
        HStack
        {
            Text("15:10")
                .font(.largeTitle)
                .foregroundColor(.white)
            
                .padding()
                .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 98, height: 65)
                    .font(target < 16 ? .headline.bold() : .headline)
                )
//                .overlay(
//                
//                    RoundedRectangle(cornerRadius: 20)
//                        .stroke(Color.purple, lineWidth: 2)
//                )
            
        }  .padding(10)
    }
}


#Preview
{
    //RatingView()
    TimeView()
}

