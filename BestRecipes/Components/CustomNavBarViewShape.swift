//
//  CustomNavBarView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct OffsetCustomBox{
  static let height: CGFloat = 150
    static let angle: CGFloat = 15
    static let radiusOne: CGFloat = 45
    static let radiusTwo: CGFloat = 30
    static  var demensionOneY: CGFloat {
        (radiusOne*sin(angle * Double.pi / 180))
    }
    static  var demensionTwoY: CGFloat {
        (radiusTwo*sin(angle * Double.pi / 180))
    }
    static  var offset: CGFloat{
               return -(height/2 - (demensionOneY+demensionTwoY)/2)
    }
}

struct CustomBox: Shape {
    var angle: CGFloat
    var radiusOne: CGFloat
    var radiusTwo: CGFloat
    var deltaX: CGFloat{
        ((radiusOne*cos(angle * Double.pi / 180))+(radiusTwo*cos(angle * Double.pi / 180)))
    }
    var deltaY: CGFloat {
        (radiusTwo-((radiusOne*sin(angle * Double.pi / 180))+(radiusTwo*sin(angle * Double.pi / 180))))
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: (rect.maxX/2)+deltaX, y: rect.minY))
        path.addArc(center: CGPoint(x: (rect.maxX/2)+deltaX, y: rect.minY+radiusTwo), radius: radiusTwo, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: -(180-angle)), clockwise: true)
        path.addArc(center: CGPoint(x: (rect.midX), y: deltaY), radius: radiusOne, startAngle: Angle(degrees: angle), endAngle: Angle(degrees: (180-angle)), clockwise: false)
        path.addArc(center: CGPoint(x: (rect.midX)-deltaX, y: rect.minY+radiusTwo), radius: radiusTwo, startAngle: Angle(degrees: (360-angle)), endAngle: Angle(degrees: 270), clockwise: true)
        path.closeSubpath()
        return path
    }
}

struct CustomNavBarViewShape: View {
    @Binding var isCheckHome: Bool
    @Binding var isCheckBookmark: Bool
    @Binding var isCheckbell: Bool
    @Binding var isCheckprofile: Bool
    var body: some View {
            HStack{
                Button{
                    resetCheck()
                    isCheckHome.toggle()
                }label: {
                    Image(!isCheckHome ? "home" : "homeRed")
                }
                Spacer()
                Button{
                    resetCheck()
                    isCheckBookmark.toggle()
                }label: {
                    Image(!isCheckBookmark ? "bookmark" : "bookmarkRed")
                }
                Spacer()
  
                Spacer()
                Button{
                    resetCheck()
                    isCheckbell.toggle()
                }label: {
                    Image(!isCheckbell ? "bell" : "bellRed")
                }
                Spacer()
                Button{
                    resetCheck()
                    isCheckprofile.toggle()
                }label: {
                    Image(!isCheckprofile ? "profile" : "profileRed")
                    
                }
            }    
    }
    func resetCheck(){
        isCheckHome = false
        isCheckBookmark = false
        isCheckbell = false
        isCheckprofile = false
    }
}



