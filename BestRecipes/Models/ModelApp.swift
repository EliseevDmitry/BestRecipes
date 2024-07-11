import Foundation

struct BookMarks: Codable {
    var idUUID = UUID()
    var bookMarkSet: Set<Int>
}

struct Recent: Codable {
    var item: [Int]
}

struct DataConstants {
    static let categories = [
        "Breakfast", "Dessert", "Appetizer", "Salad",
        "Bread", "Soup", "Beverage", "Sauce", "Marinade",
        "Fingerfood", "Snack", "Drink", "Main course", "Side dish"
    ]
    
    static let cuisines = [
        "African", "Asian", "American", "British", "Cajun", "Caribbean",
        "Chinese", "Eastern European", "European", "French", "German",
        "Greek", "Indian", "Irish", "Italian", "Japanese", "Jewish",
        "Korean", "Latin American", "Mediterranean", "Mexican",
        "Middle Eastern", "Nordic", "Southern", "Spanish", "Thai", "Vietnamese"
    ]
}
