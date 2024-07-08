//
//  PopularItemView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 30.06.2024.
//

import SwiftUI

struct PopularItemView: View, Hashable {
    // входные параметры, которые могут приходить из сети
    var id: Int
    var cuisine: String?
    var foodFoto: String
    var title: String
    var time: String
    var bookmarkIsOn: Bool // свойство отражает включена ли закладка
    
    // ширина карточки - все остальные размеры зависят от нее
    let cardWidth: Double
    
    // остальные размеры
    private var cardHeight: Double { cardWidth / 150 * 231 + foodFotoShadowRadius }
    
    private var cardBgHeight: Double { cardWidth / 150 * 176 }
    private var cardBgCornerRadius: Double { cardWidth / 150 * 16 }
    
    private var foodFotoWidth: Double { cardWidth / 150 * 110 }
    private var foodFotoShadowRadius: Double { cardWidth / 150 * 3 }
    private var foodFotoVerticalOffset: Double { cardBgHeight / 2 }
    
    private var titleWidth: Double { cardWidth * 0.8 }
    private var titleFontSize: Double { cardWidth * 0.09 }
    
    private var timeFontSize: Double { cardWidth * 0.1 }
    
    private var bookmarkWidth: Double { cardWidth / 150 * 16 * 0.8 }
    private var bookmarkHeight: Double { cardWidth / 150 * 16 }
    private var bookmarkBgWidth: Double { cardWidth / 150 * 24 }
    
    private var bottomBlockWidth: Double { cardWidth * 0.8 }
    private var bottomBlockPadding: Double { cardWidth * 0.1 }
    
    var body: some View {
        VStack{
            ZStack{
                RoundedRectangle(cornerRadius: cardBgCornerRadius)
                    .foregroundStyle(.neutral10)
                VStack{

                    Spacer()
                    Spacer()
                    Text(title)
                    //.frame(width: titleWidth)
                        .font(.custom(Poppins.semiBold, size: titleFontSize))
                        .multilineTextAlignment(.center)
                        .lineLimit(4)
                        //.padding()
                    Spacer()
                    HStack(alignment: .bottom) {
                        // время приготовления блюда
                        
                        VStack(alignment: .leading) {
                            Text("Time")
                                .foregroundStyle(.neutral30)
                            Text(time)
                        }
                        .font(.custom(Poppins.semiBold, size: timeFontSize))
                        Spacer()
                        // закладка (может быть включена и не включена)
                        ZStack {
                            // круглый фон для закладки
                            Circle()
                                .frame(width: bookmarkBgWidth)
                                .foregroundColor(.white)
                            //закладка (если включена - красная, если нет - серая)
                            Image(bookmarkIsOn ? "Iconebookmark" : "bookmark")
                                .resizable()
                                .frame(width: bookmarkWidth, height: bookmarkHeight)
                        }
                    }
                  
                }
                .padding()
                AsyncImage(url: URL(string: foodFoto))
                {image in
                    image
                        .image?.resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: foodFotoWidth, height: foodFotoWidth)
                        .shadow(radius: foodFotoShadowRadius)
                        .offset(CGSize(width: 0, height: -foodFotoVerticalOffset))
                }
            }
            .frame(width: cardWidth, height: cardBgHeight)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    PopularItemView(
        id: 1,
        foodFoto: "",
        title: "Chicken and Vegetable wrap",
        time: "5 Mins",
        bookmarkIsOn: true,
        cardWidth: 350
    )
}

