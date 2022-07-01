//
//  URLConfigurable.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

protocol URLConfigurable {
    var path: String {get}
}

extension URLConfigurable {
    var scheme: String {
        "http"
    }
    var host: String {
        "3.38.98.51"
    }
}
