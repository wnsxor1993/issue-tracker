//
//  EndPoint.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

protocol EndPointable {
    var queryItems: [URLQueryItem]? {get}
    var url: URL {get}
}
