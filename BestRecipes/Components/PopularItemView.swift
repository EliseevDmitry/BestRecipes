
import SwiftUI

struct PopularItemView: View, Equatable {
    
    static func == (lhs: PopularItemView, rhs: PopularItemView) -> Bool {
        return lhs.id == rhs.id
    }
    
    @ObservedObject var appManager: RecipesManager
    
    // входные параметры, которые могут приходить из сети
    var id: Int
    var cuisine: String?
    var foodFoto: String
    var title: String
    var time: Int
    
    var body: some View {
        GeometryReader { geometry in
            // ширина карточки - все остальные размеры зависят от нее, а она зависит от пространства, которое выделят карточке на экране HomeView
            let cardWidth: Double = geometry.size.width
            
            // остальные размеры
            var cardHeight: Double { cardWidth / 150 * 231 + foodFotoShadowRadius }
            
            var cardBgHeight: Double { cardWidth / 150 * 176 }
            var cardBgCornerRadius: Double { cardWidth / 150 * 16 }
            
            var foodFotoWidth: Double { cardWidth / 150 * 110 }
            var foodFotoShadowRadius: Double { cardWidth / 150 * 3 }
            var foodFotoVerticalOffset: Double { cardBgHeight / 2 }
            
            var titleWidth: Double { cardWidth * 0.8 }
            var titleFontSize: Double { cardWidth * 0.08 }
            var titleVerticalOffset: Double { cardBgHeight / 13 }
            
            var timeFontSize: Double { cardWidth * 0.08 }
            
            var bottomBlockWidth: Double { cardWidth * 0.8 }
            var bottomBlockPadding: Double { cardWidth * 0.1 }
            
            ZStack(alignment: .bottom) {
                // общие габариты компонента, чтобы их можно было учитывать  при его добавлении в сложную композицию на HomeView
                Rectangle()
                    .frame(width: cardWidth, height: cardHeight)
                    .opacity(0)
                
                // начинается карточка: ее фон, фото и название блюда
                ZStack {
                    // фон карточки
                    RoundedRectangle(cornerRadius: cardBgCornerRadius)
                        .frame(width: cardWidth, height: cardBgHeight)
                        .foregroundStyle(.neutral10)
                    
                    // название популярного блюда
                    Text(title)
                        .frame(width: titleWidth)
                        .font(.custom(Poppins.semiBold, size: titleFontSize))
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                    
                    // фото популярного блюда
                    AsyncImage(url: URL(string: foodFoto)) { image in
                        image
                            .image?.resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: foodFotoWidth, height: foodFotoWidth)
                            .shadow(radius: foodFotoShadowRadius)
                            .offset(CGSize(width: 0, height: -foodFotoVerticalOffset))
                    }
                }
                
                // нижний горизонтальный блок карточки: время и закладка
                HStack(alignment: .bottom) {
                    
                    // время приготовления блюда
                    VStack(alignment: .leading) {
                        Text("Time")
                            .foregroundStyle(.neutral30)
                        Text("\(time) Mins")
                    }.font(.custom(Poppins.semiBold, size: timeFontSize))
                    
                    Spacer()
                    
                    // закладка (может быть включена и не включена)
                    BookmarkView(appManager: appManager, id: id)
                }
                .frame(width: bottomBlockWidth)
                .padding(.bottom, bottomBlockPadding)
            }
        }
    }
}

#Preview {
    PopularItemView(
        appManager:RecipesManager(),
        id: 1,
        foodFoto: "mockImage1",
        title: "Chicken and Vegetable wrap Chicken and Vegetable wrap Chicken and Vegetable wrap",
        time: 5
    )
    .frame(width: 250)
}

