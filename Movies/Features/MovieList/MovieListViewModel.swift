//
//  MovieListViewModel.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

protocol MovieListViewModelProtocol: AnyObject {
    var navTitle: String { get }
    func fetchMoviesList(page: Int, searchedString: String)
    func numberOfRows(in section: Int) -> Int
    func getCellViewModel(at index: Int) -> MovieCellVMRepresentable?
    func clearSearchedMovies()
    func getImdbId(at index: Int) -> String?
}

protocol MovieListViewModelDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func hideTableView()
    func showTableView()
    func reloadTable()
    func showError(title: String, msg: String)}

final class MovieListViewModel: MovieListViewModelProtocol {
    private let service: MovieListServiceProtocol
    private weak var delegate: MovieListViewModelDelegate?
    private(set) var moviesCellViewModels: [MovieCellVMRepresentable] = []

    init(service: MovieListServiceProtocol, delegate: MovieListViewModelDelegate?) {
        self.service = service
        self.delegate = delegate
    }

    var navTitle: String {
        return "Movies"
    }

    func fetchMoviesList(page: Int, searchedString: String) {
        self.delegate?.hideTableView()
        self.delegate?.showLoader()
        service.fetchMovies(page: page, searchedString: searchedString) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.showTableView()
            self.delegate?.hideLoader()
            switch result {
            case .success(let movies):
                self.createCellViewModels(from: movies.searchedList)
                self.delegate?.reloadTable()
            case .failure:
                self.delegate?.showError(title: "Error", msg: "Something went wrong")
            }
        }
    }

    func clearSearchedMovies() {
        moviesCellViewModels.removeAll()
    }

    func numberOfRows(in section: Int) -> Int {
        return moviesCellViewModels.count
    }

    func getCellViewModel(at index: Int) -> MovieCellVMRepresentable? {
        guard moviesCellViewModels.count > index else { return nil }
        let movieCellVM = moviesCellViewModels[index]
        return movieCellVM
    }

    func getImdbId(at index: Int) -> String? {
        guard moviesCellViewModels.count > index else { return nil }
        if let movieCellVM = moviesCellViewModels[index] as? MovieCellViewModel {
            return movieCellVM.imdbId
        }
        return nil
    }
}

private extension MovieListViewModel {
    func createCellViewModels(from searchedMovieList: [SearchedMovie]?) {
        moviesCellViewModels.removeAll()
        guard let searchedMovieList = searchedMovieList,
              !searchedMovieList.isEmpty else {
            return
        }
        for movie in searchedMovieList {
            let cellVM = MovieCellViewModel(rowType: .movie, imdbId: movie.imdbID, title: movie.title, type: movie.type, year: movie.year, poster: movie.poster)
            moviesCellViewModels.append(cellVM)
        }
    }
}
