
import SwiftUI

struct Frame1View: View, Equatable {
    @ObservedObject var appManager: RecipesManager
    @State var randomElement: String = DataConstants.cuisines.randomElement()!
    var id: Int
    var foodFoto: String
    var title: String
    var cuisines: [String]
    //RandomDate
    var myDate = Date().timeIntervalSince1970 + (Double.random(in: 1...100000))
    var time: String {
        let date = NSDate(timeIntervalSince1970: myDate)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let strDate = formatter.string(from: date as Date)
        return strDate
    }
    
    static func == (lhs: Frame1View, rhs: Frame1View) -> Bool {
        return lhs.id == rhs.id
    }
    
    var body: some View {
        VStack {
          
                ZStack {
                    AsyncImage(url: URL(string: foodFoto)) { phase in
                        switch phase {
                        case .empty:
                            Image(systemName: "wifi.slash")
                            .resizable()
                        case .success(let image):
                            image
                            .resizable()
                        case .failure(_):
                            Image(systemName: "wifi.slash")
                            .resizable()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .scaledToFill()
                    
                    VStack {
                        HStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.secondary)
                                    .frame(width: 58, height: 28)
                                HStack {
                                    Image(systemName: "star.fill")
                                        .frame(width: 16, height: 16)
                                    Text(String(format: "%.1f", Double.random(in: 3.6...5.0)))
                                        .font(.custom(Poppins.bold, size: 14))
                                        .foregroundStyle(.white)
                                }
                            }
                            Spacer()
                            BookmarkView(appManager: appManager, id: id)
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.secondary)
                                    .frame(width: 41, height: 25)
                                Text(time)
                                    .font(.custom(Poppins.regular, size: 12))
                                    .foregroundStyle(.white)
                            }
                        }
                    }
                    .frame(maxHeight: 184)
                    .padding(.vertical, 16)
                    .padding(.horizontal, 10)
                }
                .frame(maxHeight: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10))
//Spacer()
               
            
            HStack {
                Text(title)
                        .frame(maxWidth: 260, alignment: .leading)
                        .font(.custom(Poppins.bold, size: 16))
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                Spacer()
            }

                HStack {
                    if let cuisine = cuisines.first {
                        Image(cuisine.lowercased().replacingOccurrences(of: " ", with: ""))
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                        Text("By \(cuisine) Foods")
                            .font(.custom(Poppins.regular, size: 12))
                            .foregroundStyle(.secondary)
                    } else {
                        Image(randomElement.lowercased().replacingOccurrences(of: " ", with: ""))
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                        Text(randomElement)
                            .font(.custom(Poppins.regular, size: 12))
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .frame(height: 32)
            
            
            Spacer()
        }
        //Spacer()
    }
}

#Preview {
    Frame1View(appManager: RecipesManager(), id: 0, foodFoto: "https://img.spoonacular.com/recipes/782601-312x231.jpg", title: "Sample Recipe Title That Is Quite Long And Needs To Be Shortened", cuisines: DataConstants.cuisines)
}

