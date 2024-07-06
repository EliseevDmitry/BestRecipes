//
//  TestBTN.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 05.07.2024.
//

import SwiftUI

struct TestBTN: View {
    let title: String
    let action: () -> Void
    @State var isSelected = false
    var body: some View {
        Button(title){
            isSelected.toggle()
            action() 
        }
            .padding(5)
            .padding(.horizontal, 8)
            .font(.custom(Poppins.semiBold, size: 20))
            .background(isSelected ? .primary50 : .neutral10)
            .foregroundStyle(isSelected ? .white : .red)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    TestBTN(title: "Example Item", action: {})
        .border(.gray)
}
