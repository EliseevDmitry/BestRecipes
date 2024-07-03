//
//  Model.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 03.07.2024.
//
import Foundation

// Структуры для декодирования ответов API
struct SearchResults: Codable {
    let results: [RecipeItem]
    let offset: Int?
    let number: Int?
    let totalResults: Int?
    
}

struct RecipeItem: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let imageType: String?
}

struct SearchResultRecipe: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let imageType: String?
}
