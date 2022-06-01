//
//  MoviewDetailViewModel.swift
//  Movies
//
//  Created by Sindhu on 01/06/22.
//

import Foundation

protocol MoviewDetailViewModelProtocol: AnyObject {
    var navTitle: String { get }
    var imdbID: String { get }
    func fetchMovieDetail()
}

protocol MoviewDetailViewModelDelegate: AnyObject {
    func reloadViews(with movieDetail: MovieDetailResponse)
    func showLoader()
    func hideLoader()
    func showError(title: String, msg: String)
}

final class MoviewDetailViewModel: MoviewDetailViewModelProtocol {

    private let service: MovieDetailServiceProtocol
    let imdbID: String
    weak var delegate: MoviewDetailViewModelDelegate?

    var navTitle: String {
        return "Movies"
    }

    init(service: MovieDetailServiceProtocol, imdbID: String, delegate: MoviewDetailViewModelDelegate) {
        self.service = service
        self.imdbID = imdbID
        self.delegate = delegate
    }

    func fetchMovieDetail() {
        service.fetchMovieDetails(imdbID: imdbID) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoader()
            switch result {
            case .success(let detail):
                self.delegate?.reloadViews(with: detail)
            case .failure:
                self.delegate?.showError(title: "Error", msg: "Something went wrong")
            }
        }
        self.delegate?.showLoader()
    }
}
