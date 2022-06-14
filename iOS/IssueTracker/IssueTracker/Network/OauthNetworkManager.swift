//
//  OauthNetworkManager.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/14.
//

import Foundation

class OauthNetworkManager {
    var endPoint: EndPoint
    var networkService: OauthNetworkService

    init(endPoint: EndPoint, networkService: OauthNetworkService){
        self.endPoint = endPoint
        self.networkService = networkService
    }

//    func enquireForeGrant() -> String {
//        
//        let url = endPoint.url
//        
//        networkService
//    }

}



