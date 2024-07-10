//
//  Model.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 30.06.2024.
//

import Foundation

class RecipesManager: ObservableObject {
    var networkManager = NetworkManager.shared
    
    var bookMark = BookMarks(bookMarkSet: Set<Int>())
        
    //сохранение данных о прохождении Onboardinga
        func saveBookMarkData(){
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(bookMark) {
                UserDefaults.standard.set(data, forKey: "bookmark")
            }
        }
    
        //загрузка данных о прохождении Onboardinga
        func loadBookMarkData(){
            let decoder = JSONDecoder()
            guard let data = UserDefaults.standard.data(forKey: "bookmark") else { return }
            guard let loadData = try? decoder.decode(BookMarks.self, from: data) else {return}
            bookMark.bookMarkSet = loadData.bookMarkSet
        }
    
    func saveIdBookMark(id: Int) -> Bool {
        defer {
            saveBookMarkData()
        }
        if !loadBookMark(id: id) {
            print("Закладка будет установлена на ID - \(id)")
            bookMark.bookMarkSet.insert(id)
            print(bookMark.bookMarkSet)
            return true
        } else {
            print("Закладка будет удалена на ID - \(id)")
            bookMark.bookMarkSet.remove(id)
            return false
        }
    }
    
    
    
    func loadBookMark(id: Int) -> Bool {
        bookMark.bookMarkSet.contains(id)
    }
}
