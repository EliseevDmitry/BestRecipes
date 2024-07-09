//
//  MocComponent.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 09.07.2024.
//

import SwiftUI

struct MockComponent: View, Hashable {
    var id: Int
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.neutral60)
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.red)
                .padding(10)
            Text("Test text")
                .font(.largeTitle)
        }
    }
}

#Preview {
    MockComponent(id: 1)
}
