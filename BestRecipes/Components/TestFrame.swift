//
//  TestFrame.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 08.07.2024.
//
//
//  Frame1View.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct TestFrame: View, Hashable {
    var id: Int
    var foodFoto: String
    var title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                AsyncImage(url: URL(string: foodFoto)) { phase in
                    switch phase {
                    case .empty:
                        Image(systemName: "wifi.slash")
                            .resizable()
                            .scaledToFill()
                            //.frame(width: 280, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            //.frame(width: 280, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    case .failure(_):
                        Image(systemName: "wifi.slash")
                            .resizable()
                            .scaledToFill()
                           // .frame(width: 280, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    @unknown default:
                        EmptyView()
                    }
                }

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
                        .padding(.top, 20)
                        ZStack {
                            Circle()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(.white)
                            Image("Iconebookmark")
                        }
                    }
                    .padding(8)
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
                .padding()
            }
            .frame(width: 280, height: 180)

            VStack(alignment: .leading, spacing: 5){
                Text(title)
                    .frame(maxWidth: 260, alignment: .leading)
                    .font(.custom(Poppins.bold, size: 16))
                    .lineLimit(2)
                    .truncationMode(.tail)
                    
                    .multilineTextAlignment(.leading)
                    .padding(.top, 10)
                //Spacer(minLength: 2)
                HStack {
                    Image("mockAvatar")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    Text("By Zellicous Foods")
                        .font(.custom(Poppins.regular, size: 12))
                        .foregroundStyle(.secondary)
                }

            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    TestFrame(id: 0, foodFoto: "https://img.spoonacular.com/recipes/782601-312x231.jpg", title: "Sample Recipe Title That Is Quite Long And Needs To Be Shortened")
}


