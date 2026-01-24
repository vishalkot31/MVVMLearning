//
//  MovieDetailViewModel.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 22/12/25.
//

import Foundation

@Observable
class MoviewDetailViewModel {
   private(set) var movie: Movie
   private let favoriteStore: FavouriteStoreProtocol
   init(movie: Movie, favoriteStore: FavouriteStoreProtocol = FavouriteStore()) {
        self.movie = movie
        self.favoriteStore = favoriteStore
    }
    
    func toggleFavourite(){
        movie.isFavourite.toggle()
    }
}
