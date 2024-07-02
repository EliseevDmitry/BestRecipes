//
//  Constants.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 01.07.2024.
//

import SwiftUI

struct Constants {
    static let indicatorsNumber = 3
    static let indicatorWidth: CGFloat = 50
    static let indicatorHeight: CGFloat = 10
    static let activeIndicatorColorAtTop: Color = .pinkish.opacity(0.8)
    static let activeIndicatorColorAtBottom: Color = .yellowish.opacity(0.8)
    static let activeIndicatorColorGradient = LinearGradient(
        colors: [activeIndicatorColorAtTop, activeIndicatorColorAtBottom],
        startPoint: .top,
        endPoint: .bottom
    )
    static let inactiveIndicatorColor = LinearGradient(
        colors: [.grayish.opacity(0.6)],
        startPoint: .top,
        endPoint: .bottom
    )
}
