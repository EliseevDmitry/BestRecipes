//
//  Frame1View.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import SwiftUI

struct Frame1View: View, Hashable {
    var id: Int
    var body: some View {
            // общий стек
            ZStack {
                VStack(alignment: .leading) {
                    // стек с видео
                    ZStack {
                        Image("mockImage1")
                            .frame(height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        // вложеные вью на картнинку
                        VStack {
                            HStack {
                                // оценка
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.secondary)
                                        .frame(width: 58, height: 28)
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .frame(width: 16, height: 16)
                                        Text("5,0")
                                            .font(.custom(Poppins.bold, size: 14))
                                            .foregroundStyle(.white)
                                    }
                                }
                                Spacer()
                                // бук марк
                                ZStack {
                                    Circle()
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(.white)
                                    Image("Iconebookmark")
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                            Spacer()
                            HStack {
                                Spacer()
                                // время
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.secondary)
                                        .frame(width: 41, height: 25)
                                    Text("15:10")
                                        .font(.custom(Poppins.regular, size: 12))
                                        .foregroundStyle(.white)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                        }
                    }
                    // стек под видео
                    VStack(alignment: .leading) {
                        Text("How to make sharwama at home")
                            .font(.custom(Poppins.bold, size: 16))
                            .padding(.vertical, 12)
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
            }
        }
    }
    

#Preview {
    Frame1View(id: 1)
}
