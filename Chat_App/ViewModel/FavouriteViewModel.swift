//
//  FavouriteViewModel.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 22/12/25.
//

import Foundation

@Observable
class FavouriteViewModel{
    
    let favouriteVM:FavouriteStoreProtocol
    private let apiService : APIServiceProtocol
    var favouriteMovies = [Movie]()
    
    init(favouriteVM: FavouriteStoreProtocol, apiService: APIServiceProtocol) {
        self.favouriteVM = favouriteVM
        self.apiService = apiService
    }
    
    func loadFvaouriteMovies() async{
        //Get favouriteID
        let favMoviesId = favouriteVM.loadFavourites()
        
        //Load All Movies
        do {
            let response:ResponseModel = try await apiService.fetchMovies()
            let fetchmovies  = response.data
            //Get favourite movies by containing ids
            favouriteMovies = fetchmovies.filter({ movie in
                favMoviesId.contains(movie.id)
            })
        }
        catch{
           print("favourite movies")
        }
    }
}
