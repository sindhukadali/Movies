//
//  MovieDetailServiceTests.swift
//  MoviesTests
//
//  Created by Sindhu on 01/06/22.
//

import XCTest
@testable import Movies

class MovieDetailServiceTests: XCTestCase {

    func testMovieDetailServiceSuccessWithValidJSON() {
        let networkManager: NetworkManagerProtocol = NetworkManagerMock(
            mockFileName: "MovieDetailValidResponse"
        )
        let expectation = self.expectation(description: "detail-service-response")
        let service = MovieDetailService(networkManager: networkManager)

        service.fetchMovieDetails(imdbID: "TestIMDB") { result in
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

    func testMovieDetailServiceWithInvalidJSON() {
        let networkManager: NetworkManagerProtocol = NetworkManagerMock(
            mockFileName: "MovieDetailInValidResponse"
        )
        let expectation = self.expectation(description: "detail-service_invalid-response")
        let service = MovieDetailService(networkManager: networkManager)

        service.fetchMovieDetails(imdbID: "TestIMDB") { result in
            switch result {
            case .success:
                expectation.fulfill()
                XCTFail("Movie detail Api cannot succeed with invalid json")
            case .failure(let error):
                expectation.fulfill()
                XCTAssertTrue(error == APIError.decodingError)
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
