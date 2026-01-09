//
//  Movie.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 20/12/25.
//

import Foundation
//Learnings
//Struct is safe and lightweight
//Codabble is protcol for json coding and encoding
//Identifiable reuired for list
//Singel responsiblity to represent video

// MARK: - ResponseModel
struct ResponseModel: Codable {
    let data: [Movie]
}

// MARK: - Datum
struct Movie: Codable,Identifiable {
    let id, title, year: String
    let rated: Rated
    let released, runtime, genre, director: String
    let writer, actors, plot, language: String
    let country, awards: String
    let poster: String
    let imdbRating, imdbID, boxOffice: String
    var isFavourite : Bool = false

    enum CodingKeys: String, CodingKey {
        case id, title, year, rated, released, runtime, genre, director, writer, actors, plot, language, country, awards, poster, imdbRating
        case imdbID = "imdbId"
        case boxOffice
    }
}

enum Rated: String, Codable {
    case approved = "Approved"
    case g = "G"
    case nA = "N/A"
    case notRated = "Not Rated"
    case pg = "PG"
    case pg13 = "PG-13"
    case r = "R"
}


let mockJSON = """
{
  "data": [
    {
      "id": "1",
      "title": "Inception",
      "year": "2010",
      "rated": "PG-13",
      "released": "16 Jul 2010",
      "runtime": "148 min",
      "genre": "Action, Sci-Fi",
      "director": "Christopher Nolan",
      "writer": "Christopher Nolan",
      "actors": "Leonardo DiCaprio",
      "plot": "A mind-bending thriller",
      "language": "English",
      "country": "USA",
      "awards": "Oscar Winner",
      "poster": "https://image.url",
      "imdbRating": "8.8",
      "imdbId": "tt1375666",
      "boxOffice": "$829,895,144"
    }
  ]
}
""".data(using: .utf8)!


extension Movie {

    static let mockFromJSON = Movie(
        id: "1",
        title: "Inception",
        year: "2010",
        rated: .pg13,
        released: "16 Jul 2010",
        runtime: "148 min",
        genre: "Action, Sci-Fi",
        director: "Christopher Nolan",
        writer: "Christopher Nolan",
        actors: "Leonardo DiCaprio",
        plot: "A mind-bending thriller",
        language: "English",
        country: "USA",
        awards: "Oscar Winner",
        poster: "https://image.url",
        imdbRating: "8.8",
        imdbID: "tt1375666",
        boxOffice: "$829,895,144",
        isFavourite: false
    )
}
