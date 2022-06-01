//
//  MovieListServiceTests.swift
//  MoviesTests
//
//  Created by Sindhu on 01/06/22.
//

import XCTest
@testable import Movies

class MovieListServiceTests: XCTestCase {

    func testMovieListServiceSuccessWithValidJSON() {
        let networkManager: NetworkManagerProtocol = NetworkManagerMock(
            mockFileName: "MovieListValidResponse"
        )
        let expectation = self.expectation(description: "list-service-response")
        let service = MovieListService(networkManager: networkManager)

        service.fetchMovies(page: 0, searchedString: "Iron") { result in
            switch result {
            case .success(let response):
                expectation.fulfill()
                XCTAssertNotNil(response, "reviews response should not be nil")
            case .failure:
                expectation.fulfill()
                XCTFail("Failed")
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testMovieListServiceWithInvalidJSON() {
        let networkManager: NetworkManagerProtocol = NetworkManagerMock(
            mockFileName: "MovieListInValidResponse"
        )
        let expectation = self.expectation(description: "list-service_invalid-response")
        let service = MovieListService(networkManager: networkManager)

        service.fetchMovies(page: 0, searchedString: "Iron") { result in
            switch result {
            case .success:
                expectation.fulfill()
                XCTFail("Moview List Api cannot succeed with invalid json")
            case .failure(let error):
                expectation.fulfill()
                XCTAssertTrue(error == APIError.decodingError)
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
