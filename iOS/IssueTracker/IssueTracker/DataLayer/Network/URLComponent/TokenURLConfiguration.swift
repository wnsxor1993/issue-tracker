//
//  UserInfoURLConfiguration.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

struct TokenURLConfiguration: URLConfigurable {
    var scheme: String = "http"
    var host: String = "3.38.98.51"
    var path: String = "/login/oauth/github"
}
