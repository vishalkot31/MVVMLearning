//
//  FavouriteView.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 22/12/25.
//

import SwiftUI

struct FavouriteView: View {
    
    @State private var viewModel = FavouriteViewModel(favouriteVM: FavouriteStore(), apiService: APIService())
    var body: some View {
        NavigationStack{
            List(viewModel.favouriteMovies){  movie in
                NavigationLink(movie.title) {
                    
                    Text("Hi")
                   // MovieDetailView()
                }
            }
        }
        
    }
}

#Preview {
    FavouriteView()
}
