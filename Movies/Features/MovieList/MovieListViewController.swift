//
//  MovieListViewController.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loader: UIActivityIndicatorView!

    var viewModel: MovieListViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    func showLoader() {

    }

    func hideLoader() {

    }

    func hideTableView() {

    }

    func showTableView() {

    }

    func reloadTable() {

    }

    func showError(title: String, msg: String) {

    }

}
