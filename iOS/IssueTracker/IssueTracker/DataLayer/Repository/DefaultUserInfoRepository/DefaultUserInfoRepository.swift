//
//  DefaultUserInfoRepository.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

protocol DefaultUserInfoRepository {
    var endPoint: EndPoint {get}
    func fetchUserInfo(completion: @escaping (TokenInfo?) -> Void)
}
