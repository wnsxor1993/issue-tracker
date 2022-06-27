//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import Foundation

protocol DefaultLoginUsecase {
//    var endPoint: EndPoint {get}
//    var responseHandler: (Bool) -> Void {get set}
    var grantResource: Observable<Codable?> { get }

    func execute()

//    func enquireForGrant(handler: @escaping (_ url: URL?) -> Void)
}
