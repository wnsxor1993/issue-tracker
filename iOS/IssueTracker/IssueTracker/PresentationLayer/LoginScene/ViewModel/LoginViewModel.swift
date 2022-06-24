//
//  LoginViewModel.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/23.
//

import Foundation

final class LoginViewModel {
    
    private var requestGithubGrantCodeUseCase: DefaultRequestGrantCodeUsecase
    private var requestAppleGrantCodeUseCase: DefaultRequestGrantCodeUsecase
    private var requestOAuthUserInfoUsecase: DefaultUserInfoUseCase
    var userInfo: Observable<UserInfo?> = Observable(nil)
    
    private var grantResource: GrantResource? {
        didSet{
            enquireForUserInfo()
        }
    }
    
    init() {
        self.requestOAuthUserInfoUsecase = RequestGithubGrantCodeUseCase()
        self.requestAppleGrantCodeUseCase = RequestAppleGrantCodeUseCase()
        self.requestOAuthUserInfoUsecase = RequestUserInfoUseCase()
    }
    
    
    func enquireForAppleGrant(){
        requestAppleGrantCodeUseCase.execute(){[weak self] result in
            switch result in {
            case .success(let grantResource):
                self?.grantResource = grantResource
            case .failure(let error):
                //TODO: ERROR HANDELING REQUIRED
                print(error)
            }
        }
    }
    
    func enquireForGitHubGrant(){
        requestGithubGrantCodeUseCase.execute(){[weak self] result in
            switch result in {
            case .success(let grantResource):
                self?.grantResource = grantResource
            case .failure(let error):
                //TODO: ERROR HANDELING REQUIRED
                print(error)
            }
        }
    }
    

}


private extension LoginViewModel {
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
