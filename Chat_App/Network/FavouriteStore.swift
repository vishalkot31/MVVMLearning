//
//  FavouriteStore.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 22/12/25.
//

import Foundation


protocol FavouriteStoreProtocol{
    func loadFavourites()-> Set<String>
    func saveFavorites(_ ids: Set<String>)
}


class FavouriteStore : FavouriteStoreProtocol {
    private let key = "favorite_movies"
    
    func saveFavorites(_ ids: Set<String>) {
        UserDefaults.standard.set(Array(ids), forKey:  key)
    }
    
    func loadFavourites() -> Set<String> {
        let ids = UserDefaults.standard.array(forKey: key) as? [String] ?? []
        return Set(ids)
    }
    
    
}
