//
//  MovieDetailsResponseModel.swift
//  Movies
//
//  Created by Sindhu on 01/06/22.
//

import Foundation

struct MovieDetailResponse: Decodable {
    let title, year, rated, released: String?
    let runtime, genre, director, writer: String?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
    }
}
