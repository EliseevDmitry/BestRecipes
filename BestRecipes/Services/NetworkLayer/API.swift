//
//  API.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 03.07.2024.
//

import Foundation

struct API {
    static let scheme = "https"
    static let host = "api.spoonacular.com"

    static let apiKey = Token.apiToken

}

struct Token {
    // сюда надо будет добавлять ключи по мере надобности, если буду заканчиваться запросы
    static let first = "c43c39b0497e4b8097041fadd20b4b81"
    static let second = "8f5e1777a6114f57849b7b0de3c210ca"
    static let third = "964e220d4a9c416bb49c29c11a8b633a"
    static let forth = "c56516ad0a6d44779012eb74893b6af2"
    static let fifth = "f9cc19628f7c4aec92404da9af033f0c"
    static let six = "b49c1606b4d744d69c543e592c416db1"
    static let seven = "2b1c595159634ca9ba0e817b419a533b"
    static let apiToken = "961884e4a54a440693fc978235b835e2"
    
    
    
}
