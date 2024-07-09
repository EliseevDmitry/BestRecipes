//
//  TestView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 09.07.2024.
//

import SwiftUI

struct TestView: View {
    @State private var trendingItems: [MockComponent] = [MockComponent(id: 1),MockComponent(id: 2),MockComponent(id: 3)]
    
    var body: some View {
        ScrollView{
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(trendingItems, id: \.self) { item in
                        item
                            .frame(width: 220, height: 220)
                    }
                }
               // .frame(height: 100)
            }
        }
        .padding(.horizontal, 20)
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    TestView()
}
