//
//  APIService.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 20/12/25.
//

import Foundation
import Alamofire

enum APIError:Error {
    case invalidUrl
    case invalidResponse
    case decodingError
}

protocol APIServiceProtocol {
    func fetchMovies<T:Codable>() async throws -> T 
}

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
