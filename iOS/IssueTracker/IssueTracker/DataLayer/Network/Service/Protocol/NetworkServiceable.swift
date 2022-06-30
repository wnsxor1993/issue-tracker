//
//  NetworkServiceable.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import Foundation

protocol NetworkServiceable {
    typealias CompletionHandler = (Result<Data, NetworkError>) -> Void
    static func requestURL(endPoint: EndPoint, completion: @escaping (Result<URL, NetworkError>) -> Void)
    static func request(endPoint: EndPoint, completion: @escaping CompletionHandler)
}
