
import SwiftUI

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
