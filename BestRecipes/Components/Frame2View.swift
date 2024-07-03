//
//  Frame2View.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct Frame2View: View {
    var body: some View {
        ScrollView(.horizontal) {
            ZStack {
                VStack {
                    Image("mockImage7")
                        .resizable()
                        .frame(width: 124, height: 124)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    VStack(alignment: .leading) {
                        Text("Kelewelw Ghanian Recipe")
                            .font(.custom(Poppins.bold, size: 14))
                            .padding(.top, 8)
                        Text("By Zeelicious Foods")
                            .font(.custom(Poppins.regular, size: 10))
                            .foregroundStyle(.secondary)
                            .padding(.top, 4)
                    }
                }
            }
            .frame(width: 124)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    Frame2View()
}
