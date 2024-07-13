
import SwiftUI

struct StartButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .padding(32)
            .frame(width: 200)
            .font(.custom(Poppins.semiBold, size: 20))
            .background(.primary50)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.bottom, 32)
    }
}

#Preview {
    StartButtonView(title: "Start", action: {})
}
