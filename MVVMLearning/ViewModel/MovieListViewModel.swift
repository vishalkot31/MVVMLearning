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

//Ensures UI-safe updates
//No need for DispatchQueue.main
//View does not know how data is loaded
class MovieListViewModel {
    //Ciew can only read and cannot change
    private(set)var movies = [Movie]()
    private(set) var favouiteMovieIds = Set<String>()
    var isLoading : Bool = false
    var serachText = ""
    var errorMessage:String?
    private let apiService : APIServiceProtocol
    private let favouriteStore : FavouriteStoreProtocol
    
    //Dependency injection and since it is based on Protcol and not on Concrete Class
    init(apiService:APIServiceProtocol,favoriteStore:FavouriteStoreProtocol){
        self.apiService = apiService
        self.favouriteStore = favoriteStore
        loadFavourites()
    }
    
    func getMovies()async{
        isLoading = true
        do {
            let response:ResponseModel = try await apiService.fetchMovies()
            let fetchmovies  = response.data
            //update favourite
            updateFvaourableMovie(movieList: fetchmovies)
        }
        catch{
            errorMessage = "failed to load movies"
        }
        isLoading = false
    }
    
    
    //logic for favourite Movies
    
    func updateFvaourableMovie(movieList:[Movie]) {
        //Load faviourite id store and update favourite property of each movie lits
        movies = movieList.map({ movie in
            var updated = movie
            updated.isFavourite =  favouiteMovieIds.contains(movie.id)
            return updated
        })
    }
    
    
    //Load stores
    func loadFavourites(){
      favouiteMovieIds = favouriteStore.loadFavourites()
    }
    
    //Computed property
    var filterMovies : [Movie] {
        guard !serachText.isEmpty else{
            return movies
        }
        return movies.filter { movie in
            movie.title.lowercased().contains(serachText.lowercased())
        }
    }
    
    //Toggle
    func toggleMovie(movieCome:Movie){
        
        guard let index  = movies.firstIndex(where: { movie in
            movie.id == movieCome.id
        }) else {
            return
        }
        
        movies[index].isFavourite.toggle()
        if movies[index].isFavourite {
            favouiteMovieIds.insert(movieCome.id)
        } else{
            favouiteMovieIds.remove(movieCome.id)
        }
        favouriteStore.saveFavorites(favouiteMovieIds)
    }
}
