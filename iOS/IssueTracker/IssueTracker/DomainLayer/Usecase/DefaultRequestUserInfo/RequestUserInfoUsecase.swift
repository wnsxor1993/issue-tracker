//
//  requestUserInfoUsecase.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

final class RequestUserInfoUsecase: DefaultRequestUserInfoUsecase {

    var userInfoRepository: DefaultUserInfoRepository?

    init(userInfoRepository: DefaultUserInfoRepository? = UserInfoRepository(endPoint: EndPoint(urlConfigure: TokenURLConfiguration(), method: .POST, body: nil))) {
        self.userInfoRepository = userInfoRepository
    }

    func execute(completion: @escaping (TokenInfo?) -> Void) {
        userInfoRepository?.fetchUserInfo(completion: { userInfo in
            guard let userInfo = userInfo else {
                completion(nil)
                return
            }
            completion(userInfo)
        })
    }

}
