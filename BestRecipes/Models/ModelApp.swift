import Foundation

struct BookMarks: Codable {
    var idUUID = UUID()
    var bookMarkSet: Set<Int>
}
