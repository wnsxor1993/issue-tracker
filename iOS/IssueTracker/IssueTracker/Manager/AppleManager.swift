//
//  AppleManager.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import AuthenticationServices

final class AppleManager: NSObject, OAuthManageable {

    let endPoint: EndPoint
    private var presentationAnchor: UIWindow?
    private var authorizationController: ASAuthorizationController?

    init(endPoint: EndPoint, presentationAnchor: UIWindow?) {
        self.endPoint = endPoint
        self.presentationAnchor = presentationAnchor
        super.init()

        self.prepareToRequest()
    }

    func sendRequest() {
        guard let controller = authorizationController else { return }
        controller.performRequests()
    }
}

private extension AppleManager {

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

extension AppleManager: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // apple 로그인 성공 관련 로직 필요
            break

        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // error 처리
    }
}

extension AppleManager: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = presentationAnchor else { return ASPresentationAnchor() }

        return window
    }
}
