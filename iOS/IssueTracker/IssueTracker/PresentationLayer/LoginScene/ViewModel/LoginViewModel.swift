//
//  LoginViewModel.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/23.
//

import Foundation
import UIKit

final class LoginViewModel {
    
    private var githubAuthorizationUsecase: DefaultLoginUsecase
    private var appleAuthorizationUsecase: DefaultLoginUsecase
    private var requestUserInfoUsecase: DefaultLoginUsecase
    var userInfo: Observable<UserInfo?> = Observable(nil)
    
    private var grantResource: GrantResource? {
        didSet{
            enquireForUserInfo()
        }
    }
    
    init() {
        appleAuthorizationUsecase.grantResource.bind { resource in
            guard let grantCode = resource as? GrantResource else { return }
        }
        
        githubAuthorizationUsecase.grantResource.bind { resource in
            guard let grantCode = resource as? GrantResource else { return }
        }
        
        self.githubAuthorizationUsecase = GithubAuthorizationUsecase()
        self.appleAuthorizationUsecase = AppleAuthorizationUsecase()
        self.requestUserInfoUsecase = RequestUserInfoUseCase()
    }
    
    func enquireGrant(buttonCase: OAuthButtonType) {
        switch buttonCase {
        case .git:
            enquireForGitHubGrant()
        case .apple:
            enquireForAppleGrant()
        }
    }
}


private extension LoginViewModel {
    
    func enquireForAppleGrant(){
        appleAuthorizationUsecase.execute { _ in }
//        appleAuthorizationUsecase.execute(){[weak self] result in
//            switch result in {
//            case .success(let grantResource):
//                self?.grantResource = grantResource
//            case .failure(let error):
//                //TODO: ERROR HANDELING REQUIRED
//                print(error)
//            }
//        }
    }
    
    func enquireForGitHubGrant(){
        githubAuthorizationUsecase.execute { url in
            guard let usefulURL = url, UIApplication.shared.canOpenURL(usefulURL) else { return }
            
            UIApplication.shared.open(usefulURL)
        }
        
//        githubAuthorizationUsecase.execute(){[weak self] result in
//            switch result in {
//            case .success(let grantResource):
//                self?.grantResource = grantResource
//            case .failure(let error):
//                //TODO: ERROR HANDELING REQUIRED
//                print(error)
//            }
//        }
    }
    
    func enquireForUserInfo(){
        requestOAuthUserInfoUsecase.execute(bodyParameter: grantResource) {[weak self] result in
            switch result in {
            case .success(let userInfo):
                self?.userInfo.updateValue(value: userInfo)
            case .failure(let error):
                //TODO: ERROR HANDELING REQUIRED
                print(error)
            }
        }
    }
}
