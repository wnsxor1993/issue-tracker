//
//  URLConfigurable.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

protocol URLConfigurable {
    var scheme: String {get}
    var host: String {get}
    var path: String {get}
    var queryItem: [URLQueryItem]? {get}
}

extension URLConfigurable {
    var scheme: String {
        "http"
    }
    var host: String {
        "3.38.98.51"
    }
}
