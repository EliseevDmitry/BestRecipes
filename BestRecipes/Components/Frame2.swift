//
//  Frame2.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 11.07.2024.
//

import SwiftUI

struct Frame2View: View {
    
    @ObservedObject var appManager: RecipesManager
    @State var randomElement: String = DataConstants.cuisines.randomElement()!
    var id: Int
    var foodFoto: String
    var title: String
    var cuisines: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: foodFoto))
            {image in
                image
                    .image?.resizable()
                    .frame(width: 124 ,height: 124)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Text(title)
                .lineLimit(2)
                .truncationMode(.tail)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .font(.custom(Poppins.bold, size: 14))
                .padding(.top, 8)
                .frame(width: 124)
            Text(randomElement)
                .font(.custom(Poppins.regular, size: 10))
                .foregroundStyle(.secondary)
                .padding(.top, 4)
        }
    }
}

#Preview {
    Frame2View(appManager: RecipesManager(), id: 0, foodFoto: "https://img.spoonacular.com/recipes/782601-312x231.jpg", title: "african", cuisines: ["african"])
}
