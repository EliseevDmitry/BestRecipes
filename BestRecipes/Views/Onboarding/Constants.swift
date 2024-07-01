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
    static let activeIndicatorColorAtTop: Color = .primary60.opacity(0.8)
    static let activeIndicatorColorAtBottom: Color = .secondary60.opacity(0.8)
    static let activeIndicatorColorGradient = LinearGradient(
        colors: [activeIndicatorColorAtTop, activeIndicatorColorAtBottom],
        startPoint: .top,
        endPoint: .bottom
    )
    static let inactiveIndicatorColor = LinearGradient(
        colors: [.neutral60.opacity(0.8)],
        startPoint: .top,
        endPoint: .bottom
    )

    static let darkeningLevel = 0.2
    
}
