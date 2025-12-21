//
//  MovieViewModel.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 20/12/25.
//

import Foundation
import Observation
@Observable
@MainActor
class MovieViewModel {
    var movies = [Movie]()
    var isLoading : Bool = false
    var errorMessage:String?
    private let apiService : APIServiceProtocol
    
    init(apiService:APIServiceProtocol){
        self.apiService = apiService
    }
    
    func getMovies()async{
        isLoading = true
        do {
            let response:ResponseModel = try await apiService.fetchMovies()
            movies  = response.data
        }
        catch{
            errorMessage = "failed to load movies"
        }
        isLoading = false
    }
}
