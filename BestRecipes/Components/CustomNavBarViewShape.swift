//
//  CustomNavBarView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

//struct CustomBox:View {
//    var body: some View {
//            GeometryReader { screen in
//                Path() {path in
//                    path.move(to: CGPoint(x: 0, y: 0))
//                    path.addLine(to: CGPoint(x: 0, y: 100))
//                    path.addLine(to: CGPoint(x: screen.size.width, y: 100))
//                    path.addLine(to: CGPoint(x: screen.size.width, y: 0))
//                    path.addLine(to: CGPoint(x: (screen.size.width/2)+50, y: 0))
//                    path.addArc(center: CGPoint(x: screen.size.width/2, y: 0), radius: 50, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
//                    path.closeSubpath()
//                }
//                .fill(.red)
//                
//            }
//    }
//}

struct CustomBox: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: (rect.maxX/2)+50, y: 0))
        path.addArc(center: CGPoint(x: rect.maxX/2, y: 0), radius: 50, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
        path.closeSubpath()
        return path
    }
}


struct CustomNavBarViewShape: View {
    var body: some View {
        VStack{
            ZStack {
                CustomBox()
                    .frame(alignment: .center)
                    .foregroundStyle(.blue)
                    .frame(height: 100)
                HStack{
                    Button{
                        
                    }label: {
                        Image("home")
                    }
                    Spacer()
                    Button{
                        
                    }label: {
                        Image("bookmark")
                    }
                    Spacer()
                    Spacer()
                    Button{
                        
                    }label: {
                        Image("bell")
                    }
                    Spacer()
                    Button{
                        
                    }label: {
                        Image("profile")
                            
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.leading, 20)
                .padding(.trailing, 20)
            }
        }
        
    }
}

#Preview {
    CustomNavBarViewShape()
}
