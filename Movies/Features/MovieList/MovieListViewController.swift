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

    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()

    var viewModel: MovieListViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.navTitle
        setupViews()
    }

    private func setupViews() {
        view.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        configureTableView()
        searchBar.delegate = self
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.contentInset.top = 12
        tableView.register(UINib(nibName: "MovieDetailsTVC", bundle: .main), forCellReuseIdentifier: MovieDetailsTVC.reuseIdentifier)
        hideTableView()
        let noResultView = EmptyStateView()
        noResultView.configureView(state: .emptyList)
        tableView.backgroundView = noResultView
    }

    private func getMovieList(searchString: String, pageNo: Int) {
        viewModel?.fetchMoviesList(page: pageNo, searchedString: searchString)
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
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

    func hideTableView() {
        DispatchQueue.main.async {
             self.tableView.isHidden = true
        }
    }

    func showTableView() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
        }
    }

    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(title: String, msg: String) {
        DispatchQueue.main.async {
            DispatchQueue.main.async {
                UIAlertController.showAlert(from: self, title: "Error", msg: msg)
            }
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numOfRows = viewModel?.numberOfRows(in: section) ?? 0
        if numOfRows > 0 {
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
        }
        return numOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.getCellViewModel(at: indexPath.row) else {
            return UITableViewCell()
        }
        switch cellViewModel.rowType {
        case .movie:
            if let cellViewModel = cellViewModel as? MovieCellViewModel {
                let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTVC.reuseIdentifier, for: indexPath) as! MovieDetailsTVC
                cell.configure(from: cellViewModel)
                return cell
            }
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let controller = sb.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        let networkManager: NetworkManagerProtocol = NetworkManager()
        let service: MovieDetailServiceProtocol = MovieDetailService(networkManager: networkManager)

        controller.viewModel = MoviewDetailViewModel(service: service, imdbID: viewModel?.getImdbId(at: indexPath.row) ?? "", delegate: controller)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MovieListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text,
              searchText.count > 3 else {
            return
        }
        getMovieList(searchString: searchText, pageNo: 1)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.clearSearchedMovies()
        tableView.reloadData()
    }
}
