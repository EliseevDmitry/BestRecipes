import SwiftUI


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



