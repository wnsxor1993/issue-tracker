//
//  HTTPPackagble.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

protocol HTTPPackageable {
    var mehtod: HTTPMethod {get}
    var headerType: String {get}
    var headerValue: String {get}
    var body: Data? {get}
}
