//
//  LoginViewModel.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/23.
//

import Foundation

final class LoginViewModel {

    private var githubAuthorizationUsecase: DefaultLoginUsecase
    private var appleAuthorizationUsecase: DefaultLoginUsecase?
    private var requestUserInfoUsecase: DefaultLoginUsecase?

    var gitOAuthPageURL: Observable<URL?> = Observable(nil)
    var userInfo: Observable<UserInfo?> = Observable(nil)

    private var grantResource: GrantResource? {
        didSet {
            enquireForUserInfo()
        }
    }

    init(_ github: DefaultLoginUsecase = GithubAuthorizationUsecase(endPoint: EndPoint(urlConfigure: GitURLConfiguration(), method: .POST, body: nil)), _ apple: DefaultLoginUsecase? = nil,
        _ requestUserInfo: DefaultLoginUsecase? = nil) {
        self.githubAuthorizationUsecase = github
        self.appleAuthorizationUsecase = apple
        self.requestUserInfoUsecase = requestUserInfo
    }

    func enquireGrant(buttonCase: OAuthButtonType) {
        switch buttonCase {
        case .git:
            githubAuthorizationUsecase.execute()
        case .apple:
            appleAuthorizationUsecase?.execute()
        }
    }
}

private extension LoginViewModel {

    func setNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateGrantResourceValue(notification:)), name: .recievedGrantResource, object: githubAuthorizationUsecase)
        NotificationCenter.default.addObserver(self, selector: #selector(updateGrantResourceValue(notification:)), name: .recievedGithubPageURL, object: githubAuthorizationUsecase)
        NotificationCenter.default.addObserver(self, selector: #selector(updateGrantResourceValue(notification:)), name: .recievedGrantResource, object: appleAuthorizationUsecase)
    }

    @objc
    func updateGrantResourceValue(notification: Notification) {
        guard let grantResource = notification.userInfo?[NotificationKey.grantResource]as? GrantResource else {return}
        self.grantResource = grantResource
    }

    @objc
    func updateGithubPageURLValue(notification: Notification) {
        guard let pageURL = notification.userInfo?[NotificationKey.githubPageURL]as? URL else {return}
        self.gitOAuthPageURL.updateValue(value: pageURL)
    }

//    func enquireForAppleGrant() {
//        appleAuthorizationUsecase.execute(){[weak self] result in
//            switch result in {
//            case .success(let grantResource):
//                self?.grantResource = grantResource
//            case .failure(let error):
//                //TODO: ERROR HANDELING REQUIRED
//                print(error)
//            }
//        }
//    }

//    func enquireForGitHubGrant() {
//        githubAuthorizationUsecase.execute(){[weak self] result in
//            switch result in {
//            case .success(let grantResource):
//                self?.grantResource = grantResource
//            case .failure(let error):
//                //TODO: ERROR HANDELING REQUIRED
//                print(error)
//            }
//        }
//    }

    func enquireForUserInfo() {
//        requestOAuthUserInfoUsecase.execute()
    }
}
