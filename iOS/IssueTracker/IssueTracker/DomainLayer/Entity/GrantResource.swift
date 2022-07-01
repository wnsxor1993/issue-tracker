//
//  GrantResource.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/24.
//

import Foundation

protocol DefaultGrantResource: Codable {
    var code: String {get}
    var identityToken: String? {get}
}

struct AppleGrantResource: DefaultGrantResource {
    let code: String
    let identityToken: String?
}

struct GitHubGrantResource: DefaultGrantResource {
    let code: String
    let identityToken: String?
}
