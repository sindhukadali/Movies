//
//  MovieDetailService.swift
//  Movies
//
//  Created by Sindhu on 01/06/22.
//

import Foundation

protocol MovieDetailServiceProtocol {
    func fetchMovieDetails(imdbID: String, completion: @escaping (Result<MovieDetailResponse, APIError>) -> Void)
}

final class MovieDetailService {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension MovieDetailService: MovieDetailServiceProtocol {
    func fetchMovieDetails(imdbID: String, completion: @escaping (Result<MovieDetailResponse, APIError>) -> Void) {
        return networkManager.fetch(
            using: MovieDetailRequest(imdbID: imdbID),
            completion: { (result: Result<MovieDetailResponse, APIError>) in
                completion(result)
            }
        )
    }
}
