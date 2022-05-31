//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {

}

protocol MovieListViewModelDelegate: AnyObject {

}

final class MovieListViewModel: MovieListViewModelProtocol {
    private let service: MovieListServiceProtocol
    private weak var delegate: MovieListViewModelDelegate?

    init(service: MovieListServiceProtocol, delegate: MovieListViewModelDelegate?) {
        self.service = service
        self.delegate = delegate
    }
}
