//
//  BookmarkView.swift
//  BestRecipes
//
//  Created by Дмитрий Трушин on 08.07.2024.
//

import SwiftUI

struct BookmarkView: View {
    @ObservedObject var appManager: RecipesManager
    @State var isSelected: Bool = false
    var id: Int
    var body: some View {
        Button{
            if appManager.saveIdBookMark(id: id) {
                isSelected = true
            } else {
                isSelected = false
            }
            
        } label: {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(height: 32)
                Image(isSelected ? "bookmarkRed" : "bookmark")
            }
        }
        .onAppear{
            if appManager.bookMark.bookMarkSet.contains(id) {
                isSelected = true
            } else {
                isSelected = false
            }
            
        }
    }
}

//#Preview {
//    //@State var test = false
//    BookmarkView(appManager: RecipesManager(), isSelected: isSelected, id: 1)
//
//}
