//
//  GitHubManager.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/17.
//

import Foundation

final class GithubAuthorizationUsecase: DefaultLoginUsecase {

    var requestUserInfoUsecase: DefaultRequestUserInfoUsecase?

    func execute() {
        NetworkService.requestURL(endPoint: EndPoint(urlConfigure: GitURLConfiguration(), method: .GET, body: nil)) { result in
            switch result {
            case .success(let url):
                NotificationCenter.default.post(name: .recievedGithubPageURL, object: self, userInfo: [NotificationKey.githubPageURL: url])
            case .failure(let error):
                print(error)
            }
        }
    }

    func setRequestUserInfo(_ grantResource: DefaultGrantResource) {
        guard let resource =  grantResource as? GitHubGrantResource, let data = encodeModel(model: resource) else {return}
        self.requestUserInfoUsecase = RequestUserInfoUsecase(userInfoRepository: UserInfoRepository(endPoint: EndPoint(urlConfigure: TokenURLConfiguration(), method: .POST, body: data)))
    }
}

private extension GithubAuthorizationUsecase {

    func encodeModel(model: GitHubGrantResource) -> Data? {
        let encoder = Encoder<GitHubGrantResource>()
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
