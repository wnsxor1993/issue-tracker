//
//  GitHubManager.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/17.
//

import Foundation

final class GithubAuthorizationUsecase: DefaultLoginUsecase {

    private(set) var endPoint: EndPoint
    var githubOpenURL: Observable<URL?> = Observable(nil)
    var grantResource: Observable<Codable?> = Observable(nil)
//  var responseHandler: (Bool) -> Void

    init(endPoint: EndPoint) {
        self.endPoint = endPoint
        self.setNotificationObserver()
    }

    func execute() {
        githubOpenURL.updateValue(value: endPoint.url)
    }

//    func execute(completion: ) {
//        githubOpenURL.updateValue(value: endPoint.url)
//    }

//    init(endPoint: EndPoint, observe responseHandler: @escaping (Bool) -> Void) {
//        self.endPoint = endPoint
//        self.responseHandler = responseHandler
//        self.setNotificationObserver()
//    }

//    func enquireForGrant(handler: @escaping (URL?) -> Void) {
//        handler(endPoint.url)
//    }
}

private extension GithubAuthorizationUsecase {
    func setNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveGrantCode(notification:)), name: .recievedGrantCode, object: nil)
    }

    @objc func didRecieveGrantCode(notification: Notification) {
        guard let grantCode = notification.userInfo?[NotificationKey.grantCode]as? String else {return}

        let grantResource = GrantResource(authorizationCode: grantCode, identityToken: nil)
        self.grantResource.updateValue(value: grantResource)
    }

//    func requestAPI(with endPoint: EndPoint) {
//        self.responseHandler(true)
////        NetworkService.request(endPoint: endPoint, completion: { result in
////            switch result {
////            case .success(let data):
////                // TODO: Decode response data
////                print(data)
////                self.responseHandler?(true)
////            case .failure(let error):
////                print(error)
////                self.responseHandler?(false)
////            }
////        })
//    }
}
