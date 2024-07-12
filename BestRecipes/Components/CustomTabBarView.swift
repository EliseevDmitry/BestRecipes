//
//  CustomTabBarView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 12.07.2024.
//

import SwiftUI

enum Tab: Int {
    case home = 0
    case bookmark = 1
    case bell = 2
    case profile = 3
    case plus = 4
}

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


struct CustomTabBarView: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Button{
                // switch to HomeView
                selectedTab = .home
            } label: {
                Image(selectedTab != .home ? "home" : "homeRed")
            }
            
            Spacer()
            
            Button{
                // switch to BookmarkView
                selectedTab = .bookmark
            } label: {
                Image(selectedTab != .bookmark ? "bookmark" : "bookmarkRed")
            }
            
            Spacer()
            Spacer()
            
            Button{
                // switch to BellView
                selectedTab = .bell
            } label: {
                Image(selectedTab != .bell ? "bell" : "bellRed")
            }
            
            Spacer()
            
            Button{
                // switch to ProfileView
                selectedTab = .profile
            } label: {
                Image(selectedTab != .profile ? "profile" : "profileRed")
            }
        }
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.home))
}
