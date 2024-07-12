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
    /*
    @ObservedObject var appManager: RecipesManager
    
    @State private var bookmarkViewIsOn = false
     */
    
    @Binding var isCheckHome: Bool
    @Binding var isCheckBookmark: Bool
    @Binding var isCheckBell: Bool
    @Binding var isCheckProfile: Bool
    
    @Binding var index: Int
    
    var body: some View {
        NavigationView {
            HStack {
                Button {
                    resetCheck()
                    isCheckHome.toggle()
                    
                    
                    
                    /*
                    HomeView(appManager: appManager)
                    index = 0
                    */
                } label: {
                    Image(!isCheckHome ? "home" : "homeRed")
                }
                
                Spacer()
                
                Button {
                    resetCheck()
                    isCheckBookmark.toggle()
                    
                    /*
                    bookmarkViewIsOn.toggle()
                    
                    NavigationLink("oooo", isActive: $bookmarkViewIsOn) {
                        BookMarkView(appManager: appManager)
                            .navigationBarBackButtonHidden()
                    }
                    */
                    
                    //                    BookMarkView(appManager: appManager)
                    index = 1
                } label: {
                    Image(!isCheckBookmark ? "bookmark" : "bookmarkRed")
                }
                
                Spacer()
                
                Spacer()
                
                Button {
                    resetCheck()
                    isCheckBell.toggle()
                    index = 2
                } label: {
                    Image(!isCheckBell ? "bell" : "bellRed")
                }
                
                Spacer()
                
                Button {
                    resetCheck()
                    isCheckProfile.toggle()
                    index = 3
                } label: {
                    Image(!isCheckProfile ? "profile" : "profileRed")
                }
            }   
        }
    }
    func resetCheck() {
        isCheckHome = false
        isCheckBookmark = false
        isCheckBell = false
        isCheckProfile = false
    }
}



