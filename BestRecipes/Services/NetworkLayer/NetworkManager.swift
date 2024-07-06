//
//  NetworkManager.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 03.07.2024.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
 
    // MARK: - Private methods
    func createURL(
        for endPoint: Endpoint,
        with query: String? = nil
    ) -> URL? {

        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endPoint.path

        components.queryItems = makeParameters(for: endPoint, with: query).compactMap {
                
            URLQueryItem(name: $0.key, value: $0.value)
        }
        return components.url
    }
   
    private func makeParameters(for endpoint: Endpoint, with query: String?) -> [String:String] {
        
        var parameters = [String:String]()
        
        parameters["apiKey"] = API.apiKey
        
        
        switch endpoint {
        case .doSearch(request: let request):
            parameters["query"] = request
        case .trending:
            parameters["sort"] = "popularity"
        case .popularCategory(category: let category):
            parameters["type"] = category
        case .cuisine(cuisine: let cuisine):
            parameters["cuisine"] = cuisine
        case .recipeInfo(id: let id):
            parameters["includeNutrition"] = "false"
        }
        
        return parameters

    }
    
    /// Выполняет сетевой запрос и обрабатывает полученные данные.
       /// - Parameters:
       ///   - url: URL запроса.
       ///   - apiKey: Ключ API для аутентификации запроса.
       ///   - session: Сессия URLSession, используемая для выполнения запроса.
       ///   - completion: Блок обратного вызова, который выполняется с результатом запроса.
    private func makeRequest<T: Codable>(
        for url: URL,
        apiKey: String,
        using session: URLSession = .shared,
        completion: @escaping(Result<T, NetworkErrors>) -> Void
    ) {

        let request = URLRequest(url: url)
        print("URL: \(url.absoluteString)")
       
        session.dataTask(with: request) {data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unexpectedError))
                return
            }
            
            let statusCode = httpResponse.statusCode

            
            if statusCode == 401 {
                _ = NSError(domain: "Unauthorized", code: 401, userInfo: nil)
                completion(.failure(.serverError(statusCode: statusCode)))
                print ("Error \(statusCode). Unauthorized")
                return
            }

            
            if statusCode == 403 {
                _ = NSError(domain: "Forbidden", code: 403, userInfo: nil)
                completion(.failure(.serverError(statusCode: statusCode)))
                print ("Error \(statusCode). Daily request limit exceeded")
                return
            }
        
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decodeData = try decoder.decode(T.self, from: data)
                completion(.success(decodeData))
                
            } catch {
                completion(.failure(.decodingError(error)))
            }
            return
        }.resume()
    }
    
    func searchRecipe(
        for request: String,
        completion: @escaping(Result<SearchResults, NetworkErrors>) -> Void
    ) {
        guard let url = createURL(for: .doSearch(request: request)) else { return }
        
        makeRequest(for: url, apiKey: API.apiKey, completion: completion)
        print("Request search recipe URL: \(url.absoluteString)")
    }
    
    func fetchTrendingRecipes(
        completion: @escaping(Result<SearchResults, NetworkErrors>) -> Void)
     {
        guard let url = createURL(for: .trending) else { return }
         
        makeRequest(for: url, apiKey: API.apiKey , completion: completion)
        print("Request trendingURL: \(url.absoluteString)")
    }
    
    func fetchPopularCategory(
        for category: String,
        completion: @escaping(Result<SearchResults, NetworkErrors>) -> Void
    ) {
        guard let url = createURL(for: .popularCategory(category: category)) else { return }
        print("Request popular category URL: \(url.absoluteString)")
        makeRequest(for: url, apiKey: API.apiKey, completion: completion)
        
    }
    
    func fetchCuisine(
        for cuisine: String,
        completion: @escaping(Result<SearchResults, NetworkErrors>) -> Void)
     {
         guard let url = createURL(for: .cuisine(cuisine: cuisine)) else { return }
         
        makeRequest(for: url, apiKey: API.apiKey , completion: completion)
        print("Request popular category URL: \(url.absoluteString)")
    }
    
    func fetchRecipeDetails(
        for id: Int,
        completion: @escaping(Result<RecipeInformation, NetworkErrors>) -> Void
    ) {
        guard let url = createURL(for: .recipeInfo(id: id)) else { return }
        
       makeRequest(for: url, apiKey: API.apiKey , completion: completion)
       print("Request RecipeDetails URL: \(url.absoluteString)")
    }
    
    
//    func fetchCategories(
//        for categories: [String],
//        completion: @escaping (String, Result<SearchResults, NetworkErrors>) -> Void) {
//            
//        categories.enumerated().forEach { index, category in
//            
//            let delay = Double(index) * 0.5 // Задержка в секундах для каждого запроса
//            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//                
//                guard let url = self.createURL(for: .doSearch(request: category)) else { return }
//                
//                self.makeRequest(for: url, apiKey: API.apiKey) { result in
//                    completion(category, result)
//                }
//            }
//        }
//    }
    
}
