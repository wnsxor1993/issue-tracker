//
//  EndPoint.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

protocol Authenticatable {
    static var host: String {get}
    static var path: String {get}
    static var clientID: String {get}
}
enum GitAuthentication: Authenticatable {

    static var host = "github.com"

    static var path = "/login/oauth/authorize"

    static var clientID: String {
        guard let filePath = Bundle.main.path(forResource: "ClientKey", ofType: "plist") else {return
            ""}

        let plist = NSDictionary(contentsOfFile: filePath)

        guard let value = plist?.object(forKey: "gitClient_ID") as? String else {return
            ""}
        return value
    }
}

enum AppleAuthentication: Authenticatable {

    static var host = "github.com"

    static var path = "/login/oauth/"

    static var clientID: String {
        guard let filePath = Bundle.main.path(forResource: "ClientKey", ofType: "plist") else {return
            ""}

        let plist = NSDictionary(contentsOfFile: filePath)

        guard let value = plist?.object(forKey: "appleClient_ID") as? String else {return
            ""}
        return value
    }
}

protocol EndPoint {
    var queryItems: [URLQueryItem] {get}
    var url: URL {get}
}

struct OauthEndPoint<Authentication: Authenticatable>: EndPoint {

    var queryItems: [URLQueryItem] = [URLQueryItem(name: "client_id", value: "\(Authentication.clientID)")]
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Authentication.host
        components.path = Authentication.path
        components.queryItems = queryItems
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)"
            )}
        return url
    }
}
