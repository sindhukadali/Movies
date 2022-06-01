//
//  MovieDetailRequestTests.swift
//  MoviesTests
//
//  Created by Sindhu on 01/06/22.
//

import XCTest
@testable import Movies

class MovieDetailRequestTests: XCTestCase {
    var request: MovieDetailRequest!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        request = MovieDetailRequest(imdbID: "TestIMDB")
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
        request = nil
    }

    func testMovieDetailAPIScheme() {
        XCTAssert(request.scheme == APIEndPoint.detail.scheme, "Movie Detail API scheme does not match")
    }

    func testMovieDetailAPIEndPoint() {
        XCTAssert(request.endPoint == APIEndPoint.detail.path, "Movie Detail API endpoint does not match")
    }

    func testMovieDetailAPIParameters() {
        var params = APIEndPoint.detail.parameters
        params.append(URLQueryItem(name: "i", value: "TestIMDB"))
        XCTAssert(request.parameters == params, "Movie Detail API parameters does not match")
    }

    func testMovieDetailAPIRequestMethod() {
        XCTAssert(request.requestMethod == .get, "Movie Detail API requires request method to be `get`")
    }

    func testMovieDetailAPIEncoding() {
        XCTAssert(request.encoding == .url, "Movie Detail API requires encoding to be `url`")
    }

    func testMovieDetailAPIBody() {
        if let body = request.body {
            XCTAssert(body.isEmpty, "Movie Detail API deos not require http body")
        } else {
            XCTAssert(request.body == nil, "Movie Detail API deos not require http body")
        }
    }
}
