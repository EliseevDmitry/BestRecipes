//
//  TestComponenet.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 06.07.2024.
//

import SwiftUI

struct TestComponenet: View {
    var body: some View {
        VStack{
            ScrollView(){
                ForEach (1..<100) {item in
                    Text("Test - \(item)")
                }
      
                }
        
            CustomNavBarViewShape()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    TestComponenet()
}
