//
//  ContentView.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 20/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var vm = MovieViewModel(apiService: APIService())

    var body: some View {
        NavigationStack{
            Group {
                    if vm.isLoading {
                        ProgressView()
                    }
                    else if let error = vm.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                    }
                    else{
                        List(vm.movies){movie in
                            Text("Movie  \(movie.title)")
                        }
                    }
                       
            } .navigationTitle("Movies")
                .navigationBarTitleDisplayMode(.inline)
        }.task {
            await vm.getMovies()
        }
    }
}

#Preview {
    ContentView()
}
