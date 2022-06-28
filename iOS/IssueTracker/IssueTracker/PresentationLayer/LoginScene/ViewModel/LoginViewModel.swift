//
//  LoginViewModel.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/23.
//

import Foundation
import UIKit

final class LoginViewModel {

    private var githubAuthorizationUsecase: DefaultLoginUsecase?
    private var appleAuthorizationUsecase: DefaultLoginUsecase?

    var gitOAuthPageURL: Observable<URL?> = Observable(nil)
    var userInfo: Observable<UserInfo?> = Observable(nil)

    private var grantResource: DefaultGrantResource? {
        didSet {
            guard let resource = grantResource else {return}
            enquireForUserInfo(resource)
        }
    }

    init(_ github: DefaultLoginUsecase?, _ apple: DefaultLoginUsecase) {
        self.githubAuthorizationUsecase = github
        self.appleAuthorizationUsecase = apple
        setNotificationObserver()
    }

    convenience init(_ apple: DefaultLoginUsecase) {
        self.init(GithubAuthorizationUsecase(endPoint: EndPoint(urlConfigure: GitURLConfiguration(), method: .POST, body: nil)), apple)
    }

    func enquireGrant(buttonCase: OAuth) {
        switch buttonCase {
        case .git:
            githubAuthorizationUsecase?.execute()
        case .apple:
            appleAuthorizationUsecase?.execute()
        }
    }
}

private extension LoginViewModel {

    func setNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateGithubPageURLValue(notification:)), name: .recievedGithubPageURL, object: githubAuthorizationUsecase)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAppleGrantResourceValue(notification:)), name: .recievedGrantResource, object: appleAuthorizationUsecase)
        NotificationCenter.default.addObserver(self, selector: #selector(updateGithubGrantResourceValue(notification:)), name: .recievedGrantCode, object: nil)
    }

    @objc
    func updateGithubGrantResourceValue(notification: Notification) {
        guard let grantCode = notification.userInfo?[NotificationKey.grantCode]as? String else {return}
        let grantResource = GitHubGrantResource(authorizationCode: grantCode, identityToken: nil)
        self.grantResource = grantResource
    }

    @objc
    func updateAppleGrantResourceValue(notification: Notification) {
        guard let grantResource = notification.userInfo?[NotificationKey.grantCode]as? AppleGrantResource else {return}
        self.grantResource = grantResource
    }

    @objc
    func updateGithubPageURLValue(notification: Notification) {
        guard let pageURL = notification.userInfo?[NotificationKey.githubPageURL]as? URL else {return}
        self.gitOAuthPageURL.updateValue(value: pageURL)
    }

    func enquireForUserInfo(_ grantResource: DefaultGrantResource) {
        switch grantResource {
        case is GitHubGrantResource:
            print(grantResource)
        case is AppleGrantResource:
            print(grantResource)
        default:
            return
        }
    }
}
