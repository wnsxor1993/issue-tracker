//
//  GitHubManager.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/17.
//

import Foundation

final class GitHubManager: OAuthManageable {

    var endPoint: EndPoint

    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }

    func enquireForGrant(handler: @escaping (URL?) -> Void) {
        handler(endPoint.url)

    }

}
