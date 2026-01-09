
//  ContentView.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 20/12/25.
//

import SwiftUI

struct MovieList: View {
    
    @State private var vm = MovieListViewModel(apiService: APIService(), favoriteStore: FavouriteStore())

    var body: some View {
        NavigationStack{
            TextField("Serach Movies", text: $vm.serachText)
                .textFieldStyle(.roundedBorder)
                .padding()
            Group {
                if vm.isLoading {
                        ProgressView()
                    }
                    else if let error = vm.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                    }
                    else{
                        List(vm.filterMovies){movie in
                            NavigationLink {
                               
                            } label: {
                                DetailRowView(movie: movie, onFavourite: {
                                    vm.toggleMovie(movieCome: movie)
                                })
                            }
                            
                        }
                    }
                       
            } .navigationTitle("Movies")
                .navigationBarTitleDisplayMode(.inline)
        }.task {
            await vm.getMovies()
        }
    }
}


struct DetailRowView:View {

    var movie:Movie
    let onFavourite:()->Void
    
    var body: some View {
        HStack {
            VStack(alignment:.leading,spacing: 10){
                Text(movie.title)
                    .font(.title)
                Text(movie.director)
                    .font(.headline)
            }
            Spacer()
            Image(systemName: movie.isFavourite ? "heart.fill" : "heart")
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    MovieList()
}
