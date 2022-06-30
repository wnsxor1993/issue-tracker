//
//  NotificationCenter.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/15.
//

import Foundation

extension Notification.Name {
    static let recievedGrantCode = Notification.Name("RecievedGrantCode")
    static let recievedGrantResource = Notification.Name("RecievedGrantResource")
    static let recievedGithubPageURL = Notification.Name("RecievedGithubPageURL")
}

enum NotificationKey {
    case grantCode
    case grantResource
    case githubPageURL
}
