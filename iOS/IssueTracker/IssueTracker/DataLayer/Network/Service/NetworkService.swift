//
//  NetworkService.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

struct NetworkService: NetworkServiceable {

    static func requestURL(endPoint: EndPoint, completion: @escaping (Result<URL, NetworkError>) -> Void) {
        var urlRequest = URLRequest(url: endPoint.url)
        urlRequest.httpMethod = endPoint.mehtod.rawValue
        urlRequest.setValue(endPoint.headerValue, forHTTPHeaderField: endPoint.headerType)
        urlRequest.httpBody = endPoint.body

        URLSession.shared.dataTask(with: urlRequest) { (_, response, error) in

            guard let httpResponse = response as? HTTPURLResponse else {return}

            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }

            guard let url = httpResponse.url, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
                return
            }
            completion(.success(url))
        }.resume()
        
    }

    static func request(endPoint: EndPoint, completion: @escaping CompletionHandler) {
        var urlRequest = URLRequest(url: endPoint.url)
        urlRequest.httpMethod = endPoint.mehtod.rawValue
        urlRequest.setValue(endPoint.headerValue, forHTTPHeaderField: endPoint.headerType)
        urlRequest.httpBody = endPoint.body

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

            guard let httpResponse = response as? HTTPURLResponse else {return}

            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.serverError(statusCode: httpResponse.statusCode)))
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
