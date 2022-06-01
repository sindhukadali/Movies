//
//  MovieDetailRequest.swift
//  Movies
//
//  Created by Sindhu on 01/06/22.
//

import Foundation

struct MovieDetailRequest: NetworkRequestData {
    let imdbID: String

    init(imdbID: String) {
        self.imdbID = imdbID
    }

    var scheme: String {
        return APIEndPoint.detail.scheme
    }

    var host: String {
        return APIEndPoint.detail.host
    }

    var endPoint: String {
        return APIEndPoint.detail.path
    }

    var parameters: [URLQueryItem] {
        var parameters = APIEndPoint.detail.parameters
        parameters.append(URLQueryItem(name: "i", value: imdbID))
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
