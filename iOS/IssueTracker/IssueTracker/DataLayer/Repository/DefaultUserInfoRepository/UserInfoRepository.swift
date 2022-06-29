//
//  UserInfoRepository.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

final class UserInfoRepository: DefaultUserInfoRepository {

    var endPoint: EndPoint

    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }

    func fetchUserInfo(completion: @escaping (UserInfo?) -> Void) {
        NetworkService.request(endPoint: endPoint) { result in
            switch result {
            case .success(let data):
                let decoder = Decoder<UserInfo>()
                let userInfo = decoder.decode(data: data)
                completion(userInfo)
            case .failure:
                completion(nil)
            }
        }
    }

}
