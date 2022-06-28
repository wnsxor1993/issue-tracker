//
//  GitHubManager.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/17.
//

import Foundation

final class GithubAuthorizationUsecase: DefaultLoginUsecase {

    private(set) var endPoint: EndPoint
    var requestUserInfoUsecase: DefaultRequestUserInfoUsecase?

    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }

    func execute() {
        NotificationCenter.default.post(name: .recievedGithubPageURL, object: self, userInfo: [NotificationKey.githubPageURL: endPoint.url])
    }

    func setRequestUserInfo(_ grantResource: GrantResource) {
        guard let data = encodeModel(model: grantResource) else {return}
        self.requestUserInfoUsecase = RequestUserInfoUsecase(userInfoRepository: UserInfoRepository(endPoint: EndPoint(urlConfigure: UserInfoURLConfiguration(), method: .POST, body: data)))
    }
}

private extension GithubAuthorizationUsecase {

    func encodeModel(model: GrantResource) -> Data? {
        let encoder = Encoder<GrantResource>()
        return encoder.encode(model: model)
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
