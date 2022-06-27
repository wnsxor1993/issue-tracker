//
//  AppleManager.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import AuthenticationServices

final class AppleAuthorizationUsecase: NSObject, DefaultLoginUsecase {

//    private(set) var endPoint: EndPoint
    var grantResource: Observable<Codable?> = Observable(nil)

    private var presentationAnchor: UIWindow?
    private var authorizationController: ASAuthorizationController?

    init(presentationAnchor: UIWindow?) {
        self.presentationAnchor = presentationAnchor
        super.init()

        self.prepareToRequest()
    }

    func execute(handler: @escaping (URL?) -> Void) {
        guard let controller = authorizationController else { return }
        controller.performRequests()
        handler(nil)
    }

//    init(endPoint: EndPoint, presentationAnchor: UIWindow?, observe responseHandler: @escaping (Bool) -> Void) {
//        self.endPoint = endPoint
//        self.presentationAnchor = presentationAnchor
//        self.responseHandler = responseHandler
//        super.init()
//
//        self.prepareToRequest()
//    }

    func enquireForGrant(handler: @escaping (URL?) -> Void) {
        guard let controller = authorizationController else { return }
        controller.performRequests()
        handler(nil)
    }
}

private extension AppleAuthorizationUsecase {

    func prepareToRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        authorizationController = controller
    }
}

extension AppleAuthorizationUsecase: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // TODO: BE API request 호출 클로저 내부에 해당 작업 넣기
            guard let authorizationCode = appleIDCredential.authorizationCode, let identityToken = appleIDCredential.identityToken, let codeString = String(data: authorizationCode, encoding: .utf8), let tokenString = String(data: identityToken, encoding: .utf8) else { return }
            let grantResource = GrantResource(authorizationCode: codeString, identityToken: tokenString)

            self.grantResource.updateValue(value: grantResource)

        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // error 처리
    }
}

extension AppleAuthorizationUsecase: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = presentationAnchor else { return ASPresentationAnchor() }

        return window
    }
}
