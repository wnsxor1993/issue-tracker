//
//  EndPoint.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

protocol EndPoint {
    var queryItems: [URLQueryItem]? {get}
    var url: URL {get}
}


struct OauthEndPoint: EndPoint {

    let urlConfigure: URLConfigurable

    var queryItems: [URLQueryItem]? {
        guard let authenticatable =  urlConfigure as? Authenticatable, let clientID = authenticatable.clientID else {return nil}
        return [URLQueryItem(name: "client_id", value: "\(clientID)")]
    }
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = urlConfigure.host
        components.path = urlConfigure.path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)"
            )}
        return url
    }

    init(urlConfigure: URLConfigurable) {
        self.urlConfigure = urlConfigure
    }
}
