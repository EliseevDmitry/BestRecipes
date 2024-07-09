import SwiftUI
import AVKit


struct VideoView: View {
    var body: some View {
        VStack {
            YouTubeWebView(videoID: "3s7opUfsin8") 
                .frame(height: 200)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0.5))
            HStack {
                Text("⭐️ 4.5 (300 Reviews)")
                    .foregroundStyle(.black)
                    .padding(.leading, -170)
                   
                  
            }
            HStack {
                VStack
                {
                    
                    Circle()
                        .frame(width: 50, height: 50)
                        .overlay(
                            
                                   Image("mockAvatar")
                                       .resizable()
                                       .scaledToFill()
                                       .frame(width: 50, height: 50)
                                       .clipShape(Circle())
                               )
                    
                }
                
                VStack(alignment: .leading) {
                    Text("Chef Fregz")
                        .font(.headline)
                    Text("📍Lagos, Nigeria")
                        .font(.subheadline)
                }
                
                Spacer()
                
                Button(action: {
                  //Follow function
                    print("button is pressed")
                }) {
                    Text("Follow")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 90, height: 45)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding()

            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    VideoView()
}
