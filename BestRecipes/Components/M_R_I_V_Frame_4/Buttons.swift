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

struct BookMark : View {
    @State private var isBooked: Bool = false
    var body: some View {
        ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 32, height: 32)
                    
                    Button(action: {
                        isBooked.toggle()
                    }) {
                        Image(isBooked ? "bookmarkRed" : "bookmark")
                            .frame(width: 24, height: 24)
                    }
        }
        
    }
}

struct TimeView: View {
    var time: String = "15:10"
    
    var body: some View {
        HStack {
            Text(time)
               
                .foregroundColor(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.3))
                        .frame(width: 70, height: 45)
                )
            
        }
        .padding(15)
    }
}


#Preview
{
    BookMark()
   // RatingView()
  // TimeView()
}
