//
//  EndPoint.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

struct EndPoint: EndPointable, HTTPPackageable {

    let mehtod: HTTPMethod
    let headerType: String = "Content-Type"
    let headerValue: String = "application/json"
    let body: Data?
    let urlConfigure: URLConfigurable

    init(urlConfigure: URLConfigurable, method: HTTPMethod, body: Data?) {
        self.urlConfigure = urlConfigure
        self.mehtod = method
        self.body = body
    }

    var queryItems: [URLQueryItem]? {
        //TODO: Issue card 정보 불러올때 사용예정 [미구현]
        return nil
    }

    var url: URL {
        var components = URLComponents()
        components.scheme = urlConfigure.scheme
        components.host = urlConfigure.host
        components.path = urlConfigure.path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)"
            )}
        return url
    }
}
