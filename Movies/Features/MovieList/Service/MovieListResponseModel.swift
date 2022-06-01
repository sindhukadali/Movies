//
//  MovieListResponseModel.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

struct MovieListResponseModel: Decodable {
    let searchedList: [SearchedMovie]?
    let totalResults: String?

    enum CodingKeys: String, CodingKey {
        case searchedList = "Search"
        case totalResults
    }
}

struct SearchedMovie: Decodable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
