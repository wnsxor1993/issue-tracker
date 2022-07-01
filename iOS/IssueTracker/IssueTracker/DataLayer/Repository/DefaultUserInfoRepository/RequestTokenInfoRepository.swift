//
//  DefaultUserInfoRepository.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

protocol RequestTokenInfoRepository {
    var endPoint: EndPoint {get}
    func fetchTokenInfo(completion: @escaping (TokenInfo?) -> Void)
}
