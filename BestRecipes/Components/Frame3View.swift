//
//  Frame3View.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct Frame3View: View {
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                Image("mockAvatar")
                    .resizable()
                    .frame(width: 110, height: 110)
                Text("Name Surname")
                    .font(.custom(Poppins.Bold, size: 12))
            }
            .padding(.horizontal, 16) 
        }
    }
}

#Preview {
    Frame3View()
}
