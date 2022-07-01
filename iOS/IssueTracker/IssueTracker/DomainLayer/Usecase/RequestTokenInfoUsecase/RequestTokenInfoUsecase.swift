//
//  DefaultRequestUserInfoUsecase.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

protocol RequestTokenInfoUsecase {
    var tokenInfoRepository: TokenInfoRepository? {get}
    func execute(completion: @escaping (TokenInfo?) -> Void)
}
