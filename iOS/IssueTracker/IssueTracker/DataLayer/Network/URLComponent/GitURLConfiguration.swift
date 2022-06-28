//
//  GitAuthentication.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

struct GitURLConfiguration: Authenticatable {

    var scheme = "https"
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
