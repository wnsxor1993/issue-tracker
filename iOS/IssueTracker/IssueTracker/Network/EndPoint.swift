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
    static var clientID: String? {get}
    static var clientSecrete: String? {get}

}

extension Bundle {

    static func searchObject(from plist: String, key: String) -> String? {
        guard let filePath = main.path(forResource: plist, ofType: "plist") else {return nil}
        let plist = NSDictionary(contentsOfFile: filePath)
        let value = plist?.object(forKey: "gitClient_ID") as? String
        return  value == nil ? nil : value
    }

}

enum GitAuthentication: Authenticatable {

    static var host = "github.com"

    static var path = "/login/oauth/authorize"

    static var clientID: String? {
        guard let clientID = Bundle.searchObject(from: "ClientKey", key: "gitClient_ID") else {return nil}
        return clientID
    }

    static var clientSecrete: String? {
        guard let clientSecrete = Bundle.searchObject(from: "ClientKey", key: "gitClient_Secrete") else {return nil}
        return clientSecrete
    }
}

protocol EndPoint {
    var queryItems: [URLQueryItem]? {get}
    var url: URL {get}
}

struct OauthEndPoint<Authentication: Authenticatable>: EndPoint {

    var queryItems: [URLQueryItem]? {
        guard let clientID =  Authentication.clientID else {return nil}
        return [URLQueryItem(name: "client_id", value: "\(clientID)")]
    }
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
