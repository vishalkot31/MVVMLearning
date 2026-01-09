//
//  APIService.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 20/12/25.
//

import Foundation
//(Open/Closed + Dependency Inversion)
//Protocol = abstraction
//Enables mocking & testing
//D: Dependency Inversion → ViewModel depends on protocol, not concrete class
//Generic
enum APIError:Error {
    case invalidUrl
    case invalidResponse
    case decodingError
}

protocol APIServiceProtocol {
    func fetchMovies<T:Codable>() async throws -> T 
}

//Concrete class
class APIService:APIServiceProtocol {
    
    func fetchMovies<T:Codable>() async throws -> T {
        let urlString = "https://fooapi.com/api/movies"
        
        guard let url = URL(string: urlString) else{
            throw APIError.invalidUrl
        }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let httpresponse = response as? HTTPURLResponse,
              httpresponse.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        }
        catch{
            throw APIError.decodingError
        }
    }
    
}

//MOCK Service class fo generic data type
class MockServiceClass:APIServiceProtocol {
    enum MockError: Error {
          case noMockData
      }
    var mockResult:Any?
    var shouldThrowError = false
    func fetchMovies<T>() async throws -> T where T : Decodable, T : Encodable {
        if shouldThrowError{
            throw APIError.invalidResponse
        }
        
        guard let result = mockResult as? T else{
            throw MockError.noMockData
        }
        
        return result
    }
}
