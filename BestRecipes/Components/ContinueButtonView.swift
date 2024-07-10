
import SwiftUI

struct ContinueButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .padding()
            .frame(width: 280)
            .font(.custom(Poppins.semiBold, size: 30))
            .background(.primary50)
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
}

#Preview {
    ContinueButtonView(title: "Continue", action: {})
}
