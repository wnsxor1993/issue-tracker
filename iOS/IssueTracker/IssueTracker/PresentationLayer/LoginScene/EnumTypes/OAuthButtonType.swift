//
//  File.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/20.
//

import Foundation

enum OAuthButtonType {
    case git
    case apple

    var image: String {
        switch self {
        case .git:
            return "github"
        case .apple:
            return "apple"
        }
    }

    var title: String {
        switch self {
        case .git:
            return "GitHub 계정으로 로그인"
        case .apple:
            return "Apple 계정으로 로그인"
        }
    }
}
