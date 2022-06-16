//
//  HTTPPackagble.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

protocol HTTPPackageable {
    var mehtod: HTTPMethod {get}
    var header: [String: String] {get}
    var body: [String: Any]? {get}
}
