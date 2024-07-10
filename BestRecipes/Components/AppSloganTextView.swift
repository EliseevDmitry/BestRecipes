
import SwiftUI

struct AppSloganTextView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .font(.custom(Poppins.regular, size: 24))
            .padding(.bottom, 24)
    }
}

#Preview {
    AppSloganTextView(text: "Find best recipes for cooking")
}
