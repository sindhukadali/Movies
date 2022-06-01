//
//  MovieListViewModelTests.swift
//  MoviesTests
//
//  Created by Sindhu on 01/06/22.
//

import XCTest
@testable import Movies

class MovieListViewModelTests: XCTestCase {
    var sut: MovieListViewModel!
    var mockDelegate: MovieListViewModelDelegateMock!
    var service: MovieListServiceMock!

    override func setUpWithError() throws {
        mockDelegate = MovieListViewModelDelegateMock()
        service = MovieListServiceMock(isError: false)
        sut = MovieListViewModel(service: service, delegate: mockDelegate)
    }

    override func tearDownWithError() throws {
        sut = nil
        service = nil
        mockDelegate = nil
    }

    func testNavTitle() {
        XCTAssertEqual(sut.navTitle, "Movies", "Its expected Nav bar Title")
    }

    func testFetchMoviesListSuccess() {
        sut.fetchMoviesList(page: 1, searchedString: "Iron")
        XCTAssertEqual(mockDelegate.isShowLoader.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isHideTable.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isHideLoader.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isShowTable.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isReloadTable.timesCalled, 1)

        XCTAssertEqual(mockDelegate.isShowError.timesCalled, 0, "no error")

        XCTAssertEqual(sut.moviesCellViewModels.count, 1, "Expected cell VM count is 1")
        if let cellVM = sut.moviesCellViewModels.first, let cellModel = cellVM as? MovieCellViewModel {
            XCTAssertEqual(cellModel.rowType, .movie)
            XCTAssertEqual(cellModel.title, "Iron Man")
            XCTAssertEqual(cellModel.year, "2005")
        } else {
            XCTFail("Could not index cell VM")
        }
    }

    func testFetchMoviesListFailure() {
        service = MovieListServiceMock(isError: true)
        sut = MovieListViewModel(service: service, delegate: mockDelegate)
        sut.fetchMoviesList(page: 1, searchedString: "Iron")

        XCTAssertEqual(mockDelegate.isShowLoader.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isHideTable.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isHideLoader.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isShowTable.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isReloadTable.timesCalled, 0)
        XCTAssertEqual(mockDelegate.isShowError.timesCalled, 1)
        if let params = mockDelegate.isShowError.params as? (String, String) {
            XCTAssertEqual(params.0, "Error")
            XCTAssertEqual(params.1, "Something went wrong")
        } else {
            XCTFail("No params")
        }
    }

    func testNumOfRows() {
        sut.fetchMoviesList(page: 1, searchedString: "Iron")
        let noOfRows = sut.numberOfRows(in: 0)
        XCTAssertEqual(noOfRows, 1)
    }

    func testCellModelAtIndexPath() {
        sut.fetchMoviesList(page: 1, searchedString: "Iron")
        if let cellVM = sut.getCellViewModel(at: 0) {
            XCTAssertEqual(cellVM.rowType, .movie)
        } else {
            XCTFail("Failed to get Cell VM at indexPath")
        }
    }

    func testGetImdbId() {
        sut.fetchMoviesList(page: 1, searchedString: "Iron")
        let imdbId = sut.getImdbId(at: 0)
        XCTAssertEqual(imdbId, "4", "Expected IMDB ID is 4")
    }
}
