//
//  NetworkService.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 24..
//

import Foundation

struct NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchAllCategories() async throws -> AllDishes {
        return try await request(route: .fetchAllCategories, method: .get)
    }
    
    func placeOrder(dishId: String, name: String) async throws -> Order {
        let params = [
            "name": name
        ]
        return try await request(route: .placeOrder(dishId), method: .post, parameters: params)
    }
    
    func fetchCategoryDishes(categoryId: String) async throws -> [Dish] {
        return try await request(route: .fetchCategoryDishes(categoryId), method: .get)
    }
    
    func fetchOrders() async throws -> [Order] {
        return try await request(route: .fetchOrders, method: .get)
    }
    
    private func request<T: Codable>(route: Route,
                             method: Method,
                             parameters: [String: Any]? = nil) async throws -> T {
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            throw AppError.unknownError
        }
        
        let (data, _) = try await URLSession.shared.data(for: request, delegate: nil)
        
        return try handleResponse(data: data)
    }
    
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        if let params = parameters {
            switch method {
                case .get:
                    var urlComponent = URLComponents(string: urlString)
                    urlComponent?.queryItems = params.map({
                        URLQueryItem(name: $0, value: "\($1)")
                    })
                    urlRequest.url = urlComponent?.url
                case .post, .delete, .patch:
                    if let bodyData = try? JSONSerialization.data(withJSONObject: params, options: []) {
                        urlRequest.httpBody = bodyData
                    }
            }
        }
        
        return urlRequest
    }
    
   private func handleResponse<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
            throw AppError.errorDecoding
        }
                
        if let error = response.error {
            throw AppError.serverError(error)
        } else if let decodedData = response.data {
            return decodedData
        } else {
            throw AppError.unknownError
        }
    }
}
