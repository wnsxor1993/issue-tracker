//
//  Authenticable.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

protocol Authenticatable: URLConfigurable {
    var clientID: String? {get}
    var clientSecrete: String? {get}
}
