//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import Foundation

protocol OAuthManageable {
    var endPoint: EndPoint {get}
    var responseHandler: (Bool) -> Void {get set}

    func enquireForGrant(handler: @escaping (_ url: URL?) -> Void)
}
