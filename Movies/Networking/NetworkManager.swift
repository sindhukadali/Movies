//
//  NetworkManager.swift
//  Movies
//
//  Created by Sindhu on 31/05/22.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(
        using networkRequestData: NetworkRequestData,
        completion: @escaping (Result<T, APIError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    let jsonDecoder: JSONDecodeProvider

    init(jsonDecoder: JSONDecodeProvider = JSONKeyDecoder()) {
        self.jsonDecoder = jsonDecoder
    }

    func fetch<T>(
        using networkRequestData: NetworkRequestData,
        completion: @escaping (Result<T, APIError>) -> Void) where T: Decodable  {

        var components = URLComponents()
        components.scheme = networkRequestData.scheme
        components.host = networkRequestData.host
        components.path = networkRequestData.endPoint
        components.queryItems = networkRequestData.parameters

        guard let url = components.url else {
            completion(.failure(.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = networkRequestData.requestMethod.rawValue

        if let body = networkRequestData.body {
            request.httpBody = body
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let _ = (response as? HTTPURLResponse)?.statusCode
            else {
                completion(.failure(.unknown))
                return
            }
            do {
                if let responseData = data {
                    let decodeResponse: T = try self.jsonDecoder.decode(data: responseData)
                    completion(.success(decodeResponse))
                } else {
                    completion(.failure(.emptyData))
                }
            } catch let error {
                print(error)
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
