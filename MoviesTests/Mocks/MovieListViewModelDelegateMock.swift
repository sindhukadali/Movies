//
//  MovieListViewModelDelegateMock.swift
//  MoviesTests
//
//  Created by Sindhu on 01/06/22.
//

import XCTest
@testable import Movies

struct MockModel {
    var timesCalled: Int = 0
    var params: Any?
}

class MovieListViewModelDelegateMock: MovieListViewModelDelegate {

    var isShowLoader = MockModel()
    func showLoader() {
        isShowLoader.timesCalled += 1
    }

    var isHideLoader = MockModel()
    func hideLoader() {
        isHideLoader.timesCalled += 1
    }

    var isHideTable = MockModel()
    func hideTableView() {
        isHideTable.timesCalled += 1
    }

    var isShowTable = MockModel()
    func showTableView() {
        isShowTable.timesCalled += 1
    }

    var isReloadTable = MockModel()
    func reloadTable() {
        isReloadTable.timesCalled += 1
    }

    var isShowError = MockModel()
    func showError(title: String, msg: String) {
        isShowError.timesCalled += 1
        isShowError.params = (title, msg)
    }
}
