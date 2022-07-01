//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import Foundation

protocol LoginUsecase {

    var requestUserInfoUsecase: RequestTokenInfoUsecase? {get}
    func execute()
    func setRequestUserInfo(_ grantResource: DefaultGrantResource)
}
