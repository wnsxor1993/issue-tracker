//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import Foundation

protocol DefaultLoginUsecase {

    var requestUserInfoUsecase: DefaultRequestUserInfoUsecase? {get}
    func execute()
    func setRequestUserInfo(_ grantResource: DefaultGrantResource)
}
