//
//  MovieListRequestTests.swift
//  MoviesTests
//
//  Created by Sindhu on 01/06/22.
//

import XCTest
@testable import Movies

class MovieListRequestTests: XCTestCase {
    var request: MovieListRequest!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        request = MovieListRequest(page: 0, searchedString: "Iron")
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
        request = nil
    }

    func testMovieListAPIScheme() {
        XCTAssert(request.scheme == APIEndPoint.movieList.scheme, "Movie List API scheme does not match")
    }

    func testMovieListAPIEndPoint() {
        XCTAssert(request.endPoint == APIEndPoint.movieList.path, "Movie List API endpoint does not match")
    }

    func testMovieListAPIParameters() {
        var params = APIEndPoint.movieList.parameters
        params.append(URLQueryItem(name: "page", value: "0"))
        params.append(URLQueryItem(name: "s", value: "Iron"))
        XCTAssert(request.parameters == params, "Movie List API parameters does not match")
    }

    func testMovieListAPIRequestMethod() {
        XCTAssert(request.requestMethod == .get, "Movie List API requires request method to be `get`")
    }

    func testMovieListAPIEncoding() {
        XCTAssert(request.encoding == .url, "Movie List API requires encoding to be `url`")
    }

    func testMovieListAPIBody() {
        if let body = request.body {
            XCTAssert(body.isEmpty, "Movie List API deos not require http body")
        } else {
            XCTAssert(request.body == nil, "Movie List API deos not require http body")
        }
    }

}
