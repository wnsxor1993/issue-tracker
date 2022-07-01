//
//  requestUserInfoUsecase.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

final class DefaultRequestTokenInfoUsecase: RequestTokenInfoUsecase {

    var tokenInfoRepository: RequestTokenInfoRepository?

    init(userInfoRepository: RequestTokenInfoRepository? = DefaultRequestTokenInfoRepository(endPoint: EndPoint(urlConfigure: TokenURLConfiguration(), method: .POST, body: nil))) {
        self.tokenInfoRepository = userInfoRepository
    }

    func execute(completion: @escaping (TokenInfo?) -> Void) {
        tokenInfoRepository?.fetchTokenInfo(completion: { userInfo in
            guard let userInfo = userInfo else {
                completion(nil)
                return
            }
            completion(userInfo)
        })
    }

}
