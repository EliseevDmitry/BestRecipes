//
//  SearchView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 02.07.2024.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        GeometryReader { screen in
            
            Path() {path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 0, y: 100))
                path.addLine(to: CGPoint(x: screen.size.width, y: 100))
                path.addLine(to: CGPoint(x: screen.size.width, y: 0))
                path.addLine(to: CGPoint(x: screen.size.width/2+100, y: 0))
                path.addQuadCurve(to: CGPoint(x: screen.size.width/2-100, y: 0), control: CGPoint(x: screen.size.width/2, y: 0))
                path.closeSubpath()
                
             
            }
            .fill(.red)
        }
    }
}

#Preview {
    SearchView()
}
