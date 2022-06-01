//
//  APIEndPoint.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

enum APIEndPoint {
    case movieList
    case detail

    var scheme: String {
        switch self {
        case .movieList, .detail:
            return Constants.Api.scheme
        }
    }

    var host: String {
        switch self {
        case .movieList, .detail:
            return Constants.Api.host
        }
    }

    var path: String {
        switch self {
        case .movieList, .detail:
            return ""
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .movieList:
            return [
                URLQueryItem(name: "i", value: Constants.Api.ttValue),
                URLQueryItem(name: "apikey", value: Constants.Api.accessKey)
            ]
        case .detail:
            return [
                URLQueryItem(name: "apikey", value: Constants.Api.accessKey)
            ]
        }
    }
}
