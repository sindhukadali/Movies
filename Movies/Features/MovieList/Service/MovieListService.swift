//
//  MovieListService.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

protocol MovieListServiceProtocol {
    func fetchMovies(page: Int, searchedString: String, completion: @escaping (Result<MovieListResponseModel, APIError>) -> Void)
}

final class MovieListService {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension MovieListService: MovieListServiceProtocol {
    func fetchMovies(page: Int, searchedString: String, completion: @escaping (Result<MovieListResponseModel, APIError>) -> Void) {
        return networkManager.fetch(
            using: MovieListRequest(page: page, searchedString: searchedString),
            completion: { (result: Result<MovieListResponseModel, APIError>) in
                completion(result)
            }
        )
    }
}
