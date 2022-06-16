//
//  NetworkService.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

protocol NetworkService {
    associatedtype Model
    typealias CompletionHandler = (Result<Model?, NetworkError>) -> Void
    func request(url: URL, method: HTTPMethod, encodedData: Data?, completion: @escaping CompletionHandler)
}

struct OauthNetworkService: NetworkService {

    typealias Model = String

    func request(url: URL, method: HTTPMethod, encodedData: Data?, completion: @escaping CompletionHandler) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }

            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(.serverError(statusCode: response.statusCode)))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(Model.self, from: data)
                completion(.success(value))
            } catch {
                completion(.failure(.decodingError(error)))
            }

        }.resume()
    }
}
