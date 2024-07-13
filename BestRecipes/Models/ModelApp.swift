import Foundation
import SwiftUI

struct BookMarks: Codable {
    var idUUID = UUID()
    var bookMarkSet: Set<Int>
}

struct Recent: Codable {
    var item: [Int]
}

// прозрачный заполнитель пространства вместо кнопки Skip для экрана OnboardingPage3View, чтобы кнопка Start Cooking не съехала вниз
struct RectangleSpacerView: View {
    var body: some View {
        Rectangle()
            .opacity(0)
            .frame(height: 40)
    }
}

struct Constants {
    static let indicatorsNumber = 3
    static let indicatorWidth: CGFloat = 50
    static let indicatorHeight: CGFloat = 10
    static let activeIndicatorColorAtTop: Color = .primary40
    static let activeIndicatorColorAtBottom: Color = .secondary20
    static let activeIndicatorColorGradient = LinearGradient(
        colors: [activeIndicatorColorAtTop, activeIndicatorColorAtBottom],
        startPoint: .top,
        endPoint: .bottom
    )
    static let inactiveIndicatorColor = LinearGradient(
        colors: [.neutral20],
        startPoint: .top,
        endPoint: .bottom
    )
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
    
    static let weight = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70,
                         75, 80, 85, 90, 100, 105, 110, 115, 120, 125, 130, 135,
                         140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190,
                         195, 200, 205, 210, 215, 220, 225, 230, 235, 240, 245,
                         250, 255, 260, 265, 270, 275, 280, 285, 290, 295, 300]
}


