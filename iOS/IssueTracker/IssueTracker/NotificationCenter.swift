//
//  NotificationCenter.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/15.
//

import Foundation

extension Notification.Name {
    static let recievedGrantCode = Notification.Name("RecievedGrantCode")
}

enum NotificationKey {
    case grantCode
}
