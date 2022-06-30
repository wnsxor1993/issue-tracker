//
//  GitAuthentication.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

struct GitURLConfiguration: URLConfigurable {
    var queryItem: [URLQueryItem]?
    var path = "/login/code/github"
}
