//
//  Frame2View.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct Frame2View: View {
    
    let imageAndTitleArray = [("mockImage7", "beef steak"),
                              ("mockImage8", "fried eggs"),
                              ("mockImage9", "fruit dessert"),
                              ("mockImage10", "hamburger"),
                              ("mockImage11", "vegetable salad")]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(imageAndTitleArray, id: \.0) { (imageName, title) in
                    VStack(alignment: .leading) {
                        Image(imageName)
                            .resizable()
                            .frame(width: 124, height: 124)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        Text(title)
                            .font(.custom(Poppins.bold, size: 14))
                            .padding(.top, 8)
                        Text("By Zeelicious Foods")
                            .font(.custom(Poppins.regular, size: 10))
                            .foregroundStyle(.secondary)
                            .padding(.top, 4)
                    }
                }
            }
        }
    }
}

#Preview {
    Frame2View()
}
