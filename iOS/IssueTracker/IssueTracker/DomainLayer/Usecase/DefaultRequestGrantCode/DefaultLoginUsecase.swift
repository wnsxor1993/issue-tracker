//
//  OAuthManager.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import Foundation

protocol DefaultLoginUsecase {
    func execute()
    var requestUserInfoUsecase: DefaultRequestUserInfoUsecase? {get}
}
