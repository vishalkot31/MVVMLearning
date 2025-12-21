//
//  Movie.swift
//  MVVMLearning
//
//  Created by Vishal Kothari on 20/12/25.
//

import Foundation


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
