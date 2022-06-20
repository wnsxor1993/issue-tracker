//
//  NetworkService.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

struct NetworkService: NetworkServiceable {

    static func request(endPoint: EndPoint, completion: @escaping CompletionHandler) {
        var urlRequest = URLRequest(url: endPoint.url)
        urlRequest.httpMethod = endPoint.mehtod.rawValue
        urlRequest.setValue(endPoint.headerValue, forHTTPHeaderField: endPoint.headerType)
        urlRequest.httpBody = endPoint.body

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
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

            completion(.success(data))

        }.resume()
    }
}
