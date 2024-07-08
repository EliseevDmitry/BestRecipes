//
//  Frame3View.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct Frame3View: View, Hashable {
    

    var cuisineFoto: String
    var title: String
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                Image(cuisineFoto)
                    .resizable()
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                Text(title)
                    .font(.custom(Poppins.bold, size: 12))
            }
            .padding(.horizontal, 8) 
        }
    }
}

#Preview {
    Frame3View(cuisineFoto: Сuisines.african, title: "African")
}
