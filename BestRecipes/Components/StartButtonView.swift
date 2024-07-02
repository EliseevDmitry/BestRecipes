//
//  StartButtonView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct StartButtonView: View {
    let title: String
    
    var body: some View {
        Button(title) {
            //
        }
        .padding(32)
        .frame(width: 200)
        .font(.custom(Poppins.SemiBold, size: 20))
        .background(.pinkish)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.bottom, 32)
    }
}

#Preview {
    StartButtonView(title: "Start")
}
