//
//  GrantResource.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/24.
//

import Foundation

struct GrantResource: Codable {
    let authorizationCode: String
    let identityToken: String?
}
