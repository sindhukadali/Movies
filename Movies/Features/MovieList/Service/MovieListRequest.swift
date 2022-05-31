//
//  MovieListRequest.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

struct MovieListRequest: NetworkRequestData {
    let page: Int
    let searchedString: String

    init(page: Int, searchedString: String) {
        self.page = page
        self.searchedString = searchedString
    }

    var scheme: String {
        return APIEndPoint.movieList.scheme
    }

    var host: String {
        return APIEndPoint.movieList.host
    }

    var endPoint: String {
        return APIEndPoint.movieList.path
    }

    var parameters: [URLQueryItem] {
        var parameters = APIEndPoint.movieList.parameters
        parameters.append(URLQueryItem(name: "page", value: "\(page)"))
        parameters.append(URLQueryItem(name: "s", value: searchedString))
        return parameters
    }

    var requestMethod: RequestMethod {
        .get
    }

    private(set) var body: Data?

    var encoding: Encoding {
        .url
    }
}
