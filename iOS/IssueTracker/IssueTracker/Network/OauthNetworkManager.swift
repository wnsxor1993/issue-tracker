//
//  OauthNetworkManager.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import UIKit

class OauthNetworkManager {
    var endPoint: EndPoint
    var networkService: OauthNetworkService

    init(endPoint: OauthEndPoint<GitAuthentication>, serivce: OauthNetworkService){
        self.endPoint = endPoint
        self.networkService = serivce
    }

    func enquireForGrant() {
        let url = endPoint.url
        print(url)
        if UIApplication.shared.canOpenURL(url) {
              UIApplication.shared.open(url)
              // redirect to scene(_:openURLContexts:) if user authorized
          }
    }
}


