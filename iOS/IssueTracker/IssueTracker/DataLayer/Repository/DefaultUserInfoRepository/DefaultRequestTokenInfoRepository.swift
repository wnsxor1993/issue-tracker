//
//  UserInfoRepository.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

final class DefaultRequestTokenInfoRepository: RequestTokenInfoRepository {

    var endPoint: EndPoint

    init(endPoint: EndPoint) {
        self.endPoint = endPoint
    }

    func fetchTokenInfo(completion: @escaping (TokenInfo?) -> Void) {
        NetworkService.request(endPoint: endPoint) { result in
            switch result {
            case .success(let data):
                let decoder = Decoder<TokenInfo>()
                let userInfo = decoder.decode(data: data)
                completion(userInfo)
            case .failure:
                completion(nil)
            }
        }
    }

}
