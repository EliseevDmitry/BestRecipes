//
//  CustomNavBarView.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct OffsetCustomBox{
    let height: CGFloat = 100
    let angle: CGFloat = 15
    let radiusOne: CGFloat = 45
    let radiusTwo: CGFloat = 30
    var demensionOneY: CGFloat {
        (radiusOne*sin(angle * Double.pi / 180))
    }
    var demensionTwoY: CGFloat {
        (radiusTwo*sin(angle * Double.pi / 180))
    }
    var offset: CGFloat{
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
    @State private var isCheckHome = false
    @State private var isCheckBookmark = false
    @State private var isCheckbell = false
    @State private var isCheckprofile = false
    let params = OffsetCustomBox()
    var body: some View {
        VStack{
            ZStack {
                CustomBox(angle: params.angle, radiusOne: params.radiusOne, radiusTwo: params.radiusTwo)
                    .frame(alignment: .center)
                    .foregroundStyle(.blue)
                    
                    .frame(height: params.height)
                   // .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.1), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, y: -5)
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
                .offset(CGSize(width: 0.0, height: -15.0)) //костыль
                .frame(maxWidth: .infinity)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                Button{
                    //action
                    //resetCheck()
                    print("Boommmm!")
                }label: {
                    ZStack {
                        Circle()
                            .frame(width: 80)
                            .foregroundStyle(.red)
                        Image(systemName: "plus")
                            .font(.title.bold())
                    }
                    .offset(CGSize(width: 0.0, height: params.offset))
                }
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

#Preview {
    CustomNavBarViewShape()
        .preferredColorScheme(.dark)
}
