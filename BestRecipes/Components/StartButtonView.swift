//
//  StartButtonView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct StartButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .padding(32)
            .frame(width: 200)
            .font(.custom(Poppins.SemiBold, size: 20))
            .background(.primary50)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.bottom, 32)
    }
}

/*
struct ContinueButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title) {}
            .padding()
            .frame(width: 280)
            .font(.custom(Poppins.SemiBold, size: 35))
            .background(.primary50)
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
}
*/

#Preview {
    StartButtonView(title: "Start", action: {})
}
