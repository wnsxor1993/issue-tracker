//
//  GitHubManager.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/17.
//

import Foundation

final class GitHubManager: OAuthManageable {

    private(set) var endPoint: EndPoint
    var responseHandler: (Bool) -> Void

    init(endPoint: EndPoint, observe responseHandler: @escaping (Bool) -> Void) {
        self.endPoint = endPoint
        self.responseHandler = responseHandler
        self.setNotificationObserver()
    }

    func enquireForGrant(handler: @escaping (URL?) -> Void) {
        handler(endPoint.url)
    }
}

private extension GitHubManager {
    func setNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveGrantCode(notification:)), name: .recievedGrantCode, object: nil)
    }

    @objc func didRecieveGrantCode(notification: Notification) {
        guard var grantCode = notification.userInfo?[NotificationKey.grantCode]as? String else {return}

        let endPoint = EndPoint(urlConfigure: GitURLConfiguration(), method: .POST, body: nil)
        self.requestAPI(with: endPoint)
    }

    func requestAPI(with endPoint: EndPoint) {
        self.responseHandler(true)
//        NetworkService.request(endPoint: endPoint, completion: { result in
//            switch result {
//            case .success(let data):
//                // TODO: Decode response data
//                print(data)
//                self.responseHandler?(true)
//            case .failure(let error):
//                print(error)
//                self.responseHandler?(false)
//            }
//        })
    }
}
