//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Sindhu on 01/06/22.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var yearLbl: UILabel!
    @IBOutlet private weak var genreLbl: UILabel!
    @IBOutlet private weak var runtimeLbl: UILabel!
    @IBOutlet private weak var directorLbl: UILabel!
    @IBOutlet private weak var writerLbl: UILabel!

    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()

    var viewModel: MoviewDetailViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.navTitle
        setupViews()
        viewModel?.fetchMovieDetail()
    }

    private func setupViews() {
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension MovieDetailViewController: MoviewDetailViewModelDelegate {

    func reloadViews(with movieDetail: MovieDetailResponse) {
        DispatchQueue.main.async {
            self.titleLbl.text = movieDetail.title
            self.genreLbl.text = movieDetail.genre
            self.yearLbl.text = movieDetail.year
            self.directorLbl.text = movieDetail.director
            self.writerLbl.text = movieDetail.writer
        }
    }

    func showLoader() {
        DispatchQueue.main.async {
            self.loader.startAnimating()
        }
    }

    func hideLoader() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }

    func showError(title: String, msg: String) {
        DispatchQueue.main.async {
            UIAlertController.showAlert(from: self, title: "Error", msg: msg)
        }
    }
}

