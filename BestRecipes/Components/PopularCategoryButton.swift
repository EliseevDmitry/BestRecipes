
import SwiftUI

struct PopularCategoryButton: View {
    let title: String
    @Binding var selectedCategory: String
    let action: () -> Void

    var body: some View {
        Button(action: {
            selectedCategory = title
            action()
        }) {
            Text(title)
                .padding(5)
                .padding(.horizontal, 8)
                .font(.custom(Poppins.semiBold, size: 12))
                .background(selectedCategory == title ? Color.primary50 : Color.white)
                .foregroundStyle(selectedCategory == title ? .white : .primary30)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}


