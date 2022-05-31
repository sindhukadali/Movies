//
//  JSONKeySnakeCaseDecoder.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

struct JSONKeyDecoder: JSONDecodeProvider {
    func decode<T: Decodable>(data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(T.self, from: data)
    }
}
