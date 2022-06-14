//
//  EndPoint.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation
enum Authentication {
    static let clientID = "d"
    static let scope = "d"
}

protocol EndPoint {
    associatedtype Item
    var path: String {get}
    var queryItems: [URLQueryItem] {get}
    var url: URL {get}
    static func getFullPath() -> Self
}

struct OauthEndPoint: EndPoint {
    typealias Item = Authentication
    var path: String
    var queryItems: [URLQueryItem]
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "github.com"
        components.path = "login/oauth/" + path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)"
            )}
        return url
    }
}

extension OauthEndPoint {
    static func getFullPath() -> OauthEndPoint {
        return OauthEndPoint(path: "authorize", queryItems: [URLQueryItem(name: "client_id", value: "\(Item.clientID)"),
                                                             URLQueryItem(name: "scope", value: "\(Item.scope)")])
    }
}
