//
//  AppleManager.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/16.
//

import AuthenticationServices

final class RequestAppleGrantCodeUseCase: NSObject, DefaultRequestGrantCodeUsecase {

    private(set) var endPoint: EndPoint
    var responseHandler: (Bool) -> Void

    private var presentationAnchor: UIWindow?
    private var authorizationController: ASAuthorizationController?

    init(endPoint: EndPoint, presentationAnchor: UIWindow?, observe responseHandler: @escaping (Bool) -> Void) {
        self.endPoint = endPoint
        self.presentationAnchor = presentationAnchor
        self.responseHandler = responseHandler
        super.init()

        self.prepareToRequest()
    }

    func enquireForGrant(handler: @escaping (URL?) -> Void) {
        guard let controller = authorizationController else { return }
        controller.performRequests()
        handler(nil)
    }

    func observe(responseHandler: @escaping (Bool) -> Void) {
        self.responseHandler = responseHandler
    }
}

private extension RequestAppleGrantCodeUseCase {

    func prepareToRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        authorizationController = controller
    }

    func requestAPI() {
        NetworkService.request(endPoint: endPoint, completion: { result in
            switch result {
            case .success(let data):
                // TODO: Decode response data
                self.responseHandler(true)
            case .failure(let error):
                self.responseHandler(false)
            }
        })
    }
}

extension RequestAppleGrantCodeUseCase: ASAuthorizationControllerDelegate {

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            // TODO: BE API request 호출 클로저 내부에 해당 작업 넣기
            requestAPI()

        default:
            break
        }
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // error 처리
    }
}

extension RequestAppleGrantCodeUseCase: ASAuthorizationControllerPresentationContextProviding {

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = presentationAnchor else { return ASPresentationAnchor() }

        return window
    }
}
