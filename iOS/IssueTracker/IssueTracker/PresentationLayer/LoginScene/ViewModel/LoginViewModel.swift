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

    var userInfo: Observable<UserInfo?> = Observable(nil)
    var gitOAuthPageURL: Observable<URL?> = Observable(nil)

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
        setGithubUsecaseOpenURLBind()
        setGrantResourceBind()
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

    func setGithubUsecaseOpenURLBind() {
        guard let githubUsecase = githubAuthorizationUsecase as? GithubAuthorizationUsecase else { return }
        githubUsecase.execute()

        //        githubUsecase.githubOpenURL.bind { url in
//            self.gitOAuthPageURL.updateValue(value: url)
//        }
    }

    func setGrantResourceBind() {
        appleAuthorizationUsecase?.grantResource.bind { resource in
            guard let grantCode = resource as? GrantResource else { return }
        }

        githubAuthorizationUsecase.grantResource.bind { resource in
            guard let grantCode = resource as? GrantResource else { return }
        }

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
