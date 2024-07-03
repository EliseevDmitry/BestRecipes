//
//  ContinueButtonView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 02.07.2024.
//

import SwiftUI

struct ContinueButtonView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(title, action: action)
            .padding()
            .frame(width: 280)
            .font(.custom(Poppins.SemiBold, size: 30))
            .background(.primary50)
            .foregroundStyle(.white)
            .clipShape(.capsule)
    }
}

#Preview {
    ContinueButtonView(title: "Continue", action: {})
}
