//
//  UserInfo.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/24.
//

import Foundation

struct TokenInfo: Codable {
    let jwtAccessToken: String
    let jwtRefreshToken: String
}
