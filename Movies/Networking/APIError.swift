//
//  APIError.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case decodingError
    case timedOut
    case emptyData
    case unknown
}
