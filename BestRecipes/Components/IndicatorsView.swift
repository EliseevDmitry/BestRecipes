//
//  IndicatorsView.swift
//  BestRecipes
//
//  Created by Денис Гиндулин on 30.06.2024.
//

import SwiftUI


struct IndicatorsView: View {
    let activeIndicatorIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<Constants.indicatorsNumber, id: \.self) { item in
                Rectangle()
                    .clipShape(.capsule)
                    .foregroundStyle(item == activeIndicatorIndex
                                     ? Constants.activeIndicatorColorGradient
                                     : Constants.inactiveIndicatorColor)
                    .frame(width: Constants.indicatorWidth, height: Constants.indicatorHeight)
            }
        }
        .padding(.bottom)
    }
}



#Preview {
    IndicatorsView(activeIndicatorIndex: 1)
}
