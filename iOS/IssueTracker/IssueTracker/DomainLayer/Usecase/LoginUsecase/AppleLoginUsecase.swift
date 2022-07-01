//
//  AppleManager.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import AuthenticationServices

final class AppleLoginUsecase: NSObject, LoginUsecase {

    // private(set) var endPoint: EndPoint
    private var presentationAnchor: UIWindow?
    private var authorizationController: ASAuthorizationController?
    var requestUserInfoUsecase: RequestTokenInfoUsecase?

    init(presentationAnchor: UIWindow?) {
        self.presentationAnchor = presentationAnchor
        super.init()

        self.prepareToRequest()
    }

    func execute() {
        guard let controller = authorizationController else { return }
        controller.performRequests()
    }

    func setRequestUserInfo(_ grantResource: DefaultGrantResource) {
        guard let resource =  grantResource as? AppleGrantResource, let data = encodeModel(model: resource) else {return}
        self.requestUserInfoUsecase = DefaultRequestTokenInfoUsecase(userInfoRepository: DefaultRequestTokenInfoRepository(endPoint: EndPoint(urlConfigure: TokenURLConfiguration(), method: .POST, body: data)))
    }

    func enquireForGrant(handler: @escaping (URL?) -> Void) {
        guard let controller = authorizationController else { return }
        controller.performRequests()
        handler(nil)
    }
}

private extension AppleLoginUsecase {

    func prepareToRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        authorizationController = controller
    }

    func encodeModel(model: AppleGrantResource) -> Data? {
        let encoder = Encoder<AppleGrantResource>()
        return encoder.encode(model: model)
    }

}

extension AppleLoginUsecase: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // TODO: BE API request 호출 클로저 내부에 해당 작업 넣기
            guard let authorizationCode = appleIDCredential.authorizationCode, let identityToken = appleIDCredential.identityToken, let codeString = String(data: authorizationCode, encoding: .utf8), let tokenString = String(data: identityToken, encoding: .utf8) else { return }
            let grantResource = AppleGrantResource(code: codeString, identityToken: tokenString)
            NotificationCenter.default.post(name: .recievedGrantResource, object: self, userInfo: [NotificationKey.grantResource: grantResource])
        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // error 처리
    }
}

extension AppleLoginUsecase: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = presentationAnchor else { return ASPresentationAnchor() }

        return window
    }
}
