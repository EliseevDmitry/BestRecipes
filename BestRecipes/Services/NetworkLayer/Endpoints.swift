//
//  Endpoints.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 03.07.2024.
//

import Foundation

enum Endpoint {
    case doSearch(request: String)
    case trending
    case popularCategory(category: String)
    case cuisine(cuisine: String)
    case recipeInfo(id: Int)
    
    /// Возвращает путь конечной точки в зависимости от выбранного запроса.
    var path: String {
        switch self {
        case .doSearch:
            return "/recipes/complexSearch"
        case .trending:
            return "/recipes/complexSearch"
        case .popularCategory:
            return "/recipes/complexSearch"
        case .cuisine:
            return "/recipes/complexSearch"
        case .recipeInfo(id: let id):
            return "/recipes/\(id)/information"
            
        }
    }
}

//https://api.spoonacular.com/recipes/complexSearch?sort=popularity&apiKey=c43c39b0497e4b8097041fadd20b4b81
//
//Request URL: https://api.spoonacular.com/recipes/complexSearch?apiKey=c43c39b0497e4b8097041fadd20b4b81&query=pasta

//https://api.spoonacular.com/recipes/complexSearch?type=salad&apiKey=c43c39b0497e4b8097041fadd20b4b81
//curl -X GET "https://api.spoonacular.com/recipes/complexSearch?cuisine=italian&apiKey=c43c39b0497e4b8097041fadd20b4b81"
// https://api.spoonacular.com/recipes/633858/information?includeNutrition=false

