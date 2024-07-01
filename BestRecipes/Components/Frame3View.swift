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
            LazyHStack {
                VStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 110, height: 110)
                        .clipShape(Circle())
                        .padding(.horizontal, 16)
                    Text("Name Surname")
                        .font(.custom(Poppins.Bold, size: 12))
                        .padding(.top, 8)
                }
            }
        }
    }
}

#Preview {
    Frame3View()
}
