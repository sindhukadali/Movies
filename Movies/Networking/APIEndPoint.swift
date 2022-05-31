//
//  APIEndPoint.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

enum APIEndPoint {
    case movieList

    var scheme: String {
        switch self {
        case .movieList:
            return Constants.Api.scheme
        }
    }

    var host: String {
        switch self {
        case .movieList:
            return Constants.Api.host
        }
    }

    var path: String {
        switch self {
        case .movieList:
            return ""
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .movieList:
            return [
                URLQueryItem(name: "i", value: Constants.Api.ttValue),
                URLQueryItem(name: "apikey", value: Constants.Api.accessKey),
            ]
        }
    }
}
