import Foundation

class RecipesManager: ObservableObject {
    var networkManager = NetworkManager.shared
    var bookMark = BookMarks(bookMarkSet: Set<Int>())
    
    var recentItem: Recent = Recent(item: [])
        
    //сохранение данных о прохождении Onboardinga
        func saveBookMarkData(){
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(bookMark) {
                UserDefaults.standard.set(data, forKey: "bookmark")
            }
        }
    
    func saveRecentData(){
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(recentItem) {
            UserDefaults.standard.set(data, forKey: "recent")
        }
    }
    
        //загрузка данных о прохождении Onboardinga
        func loadBookMarkData(){
            let decoder = JSONDecoder()
            guard let data = UserDefaults.standard.data(forKey: "bookmark") else { return }
            guard let loadData = try? decoder.decode(BookMarks.self, from: data) else {return}
            bookMark.bookMarkSet = loadData.bookMarkSet
            
        }
    
    func loadRecentData(){
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: "recent") else { return }
        guard let loadData = try? decoder.decode(Recent.self, from: data) else {return}
        recentItem.item = loadData.item
        
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

    
    
    func addRecentData(id: Int){
        defer {
            saveRecentData()
        }
        if recentItem.item.contains(id){
            print("Элемент с новером - \(id) есть в списке")
            return
        }
        if recentItem.item.count < 6 {
            recentItem.item.append(id)
            print("добавлен новый элемент - \(recentItem.item)")
        } else {
            recentItem.item.remove(at: 0)
            recentItem.item.append(id)
            print("Удален первый - добавлен новый элемент - \(recentItem.item)")
        }
        return
    } 
}
