
import SwiftUI

struct Frame1View: View, Equatable {
    static func == (lhs: Frame1View, rhs: Frame1View) -> Bool {
        return lhs.id == rhs.id
    }
    

    
    @ObservedObject var appManager: RecipesManager
    var id: Int
    var foodFoto: String
    var title: String
    var cuisines: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
                        ZStack {
                            BookmarkView(appManager: appManager, id: id)
//                            Circle()
//                                .frame(width: 32, height: 32)
//                                .foregroundStyle(.white)
//                            Image("Iconebookmark")
                        }
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.secondary)
                                .frame(width: 41, height: 25)
                            Text("15:10")
                                .font(.custom(Poppins.regular, size: 12))
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.bottom, 20)
                .padding(.top, 20)
                .padding(.horizontal, 5)
            }
            .frame(height: 180)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.bottom, 0)
            Text(title)
                .frame(maxWidth: 260, alignment: .leading)
                .font(.custom(Poppins.bold, size: 16))
                .lineLimit(2)
                .truncationMode(.tail)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .padding(.top, 10)
            Spacer()
            HStack {
                if let cuisine = cuisines.first {
                    Image(cuisine.lowercased().replacingOccurrences(of: " ", with: ""))
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 32, height: 32)
                    Text("By \(cuisine) Foods")
                        .font(.custom(Poppins.regular, size: 12))
                        .foregroundStyle(.secondary)
                } else {
                    Image("asian")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 32, height: 32)
                    Text("By Foods")
                        .font(.custom(Poppins.regular, size: 12))
                        .foregroundStyle(.secondary)
                }
            }
            if !cuisines.isEmpty {
                Text(cuisines.joined(separator: ", "))
                    .font(.custom(Poppins.regular, size: 12))
                    .foregroundColor(.gray)
                    .padding(.top, 5)
            }
        }
        .frame(width: 280)
    }
}

//#Preview {
//    Frame1View(appManager: RecipesManager(), id: 0, foodFoto: "https://img.spoonacular.com/recipes/782601-312x231.jpg", title: "Sample Recipe Title That Is Quite Long And Needs To Be Shortened")
//}

