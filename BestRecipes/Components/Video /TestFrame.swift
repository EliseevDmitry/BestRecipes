//
//  TestFrame.swift
//  BestRecipes
//
//  Created by Dmitriy Eliseev on 13.07.2024.
//

import SwiftUI

struct TestFrame: View {
    var body: some View {
        VStack{
     
                
                Frame1View(appManager: RecipesManager(), id: 0, foodFoto: "https://img.spoonacular.com/recipes/782601-312x231.jpg", title: "Sample Recipe Title That Is Quite Long And Needs To Be Shortened", cuisines: DataConstants.cuisines)
        
                Frame1View(appManager: RecipesManager(), id: 0, foodFoto: "https://img.spoonacular.com/recipes/782601-312x231.jpg", title: "Sample Recipe Title That Is Quite Long And Needs To Be Shortened", cuisines: DataConstants.cuisines)
                 

           
        }
    }
}

#Preview {
    TestFrame()
}
