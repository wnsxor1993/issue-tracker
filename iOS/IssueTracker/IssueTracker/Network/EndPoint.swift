//
//  EndPoint.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

protocol URLConfigurable {
    var host: String {get}
    var path: String {get}
}

protocol Authenticatable: URLConfigurable {
    var clientID: String? {get}
    var clientSecrete: String? {get}
}

extension Bundle {

    static func searchObject(from plist: String, key: String) -> String? {
        guard let filePath = main.path(forResource: plist, ofType: "plist") else {return nil}
        let plist = NSDictionary(contentsOfFile: filePath)
        let value = plist?.object(forKey: "gitClient_ID") as? String
        return  value == nil ? nil : value
    }

}

struct GitAuthentication: Authenticatable {

    var host = "github.com"
    var path = "/login/oauth/authorize"

    var clientID: String? {
        guard let clientID = Bundle.searchObject(from: "ClientKey", key: "gitClient_ID") else {return nil}
        return clientID
    }

    var clientSecrete: String? {
        guard let clientSecrete = Bundle.searchObject(from: "ClientKey", key: "gitClient_Secrete") else {return nil}
        return clientSecrete
    }
}

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
