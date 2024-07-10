
import SwiftUI

struct BookmarkView: View {
    
    @State private var isSelected = false
    
    var body: some View {
        Button{
            isSelected.toggle()
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(height: 32)
                Image(isSelected ? "bookmarkRed" : "bookmark")
            }
        }
    }
}

#Preview {
    BookmarkView()
        .preferredColorScheme(.dark)
}
