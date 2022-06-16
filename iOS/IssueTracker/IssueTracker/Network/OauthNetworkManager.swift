//
//  OauthNetworkManager.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

final class OauthNetworkManager {
    var endPoint: EndPoint
    var networkService: OauthNetworkService

    init(endPoint: EndPoint, serivce: OauthNetworkService) {
        self.endPoint = endPoint
        self.networkService = serivce
    }

    func enquireForGrant(handler: @escaping (_ url: URL) -> Void) {
       handler(endPoint.url)
    }

//    func requestForAccessToken(grantCode : String, ) {
//        
//    }

}
