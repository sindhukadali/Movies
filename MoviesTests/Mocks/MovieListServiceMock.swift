//
//  MovieListServiceMock.swift
//  MoviesTests
//
//  Created by Sindhu on 01/06/22.
//

import XCTest
@testable import Movies

class MovieListServiceMock: MovieListServiceProtocol {

    private let isError: Bool
    private let testError = APIError.unknown
    private let listResponse = MovieListResponseModel(searchedList: [SearchedMovie(title: "Iron Man", year: "2005", imdbID: "4", type: "Fiction", poster: "iron.png")], totalResults: "1")

    init(isError: Bool) {
        self.isError = isError
    }

    func fetchMovies(page: Int, searchedString: String, completion: @escaping (Result<MovieListResponseModel, APIError>) -> Void) {
        if isError {
            completion(.failure(testError))
        } else {
            completion(.success(listResponse))
        }
    }
}
