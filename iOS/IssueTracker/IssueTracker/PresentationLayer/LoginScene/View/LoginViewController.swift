//
//  ViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/13.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {

    private var appleManager: DefaultLoginUsecase?
    private var githubManager: DefaultLoginUsecase?
    let loginVM = LoginViewModel()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 48)
        label.text = "Issue Tracker"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var loginInputView: LoginInputView = {
        let view = LoginInputView(frame: view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var oauthLoginView: OAuthLoginView = {
        let view = OAuthLoginView(frame: view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .issueTrackerGray1
        setViewsConstraint()
        setOAuthManagers()
        oauthLoginView.delegate = self
        
        loginVM.userInfo.bind { info in
            guard let userInfo = info else { return }
            print(userInfo)
            self.presentNextScene()
        }
    }
}

extension LoginViewController: OAuthButtonDelegate {
    func didClick(buttonType: OAuthButtonType) {

        guard let githubManager = githubManager, let appleManager = appleManager else {return}

        switch buttonType {
        case .git:
            githubManager.enquireForGrant { url in
                guard let url = url else {return }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }

        case .apple:
            appleManager.enquireForGrant {_ in}
        }
    }
}

private extension LoginViewController {

    func setOAuthManagers() {
        //TODO: OAuth BE 연결되면 presentNextScene 삭제 및 로직 변경 필요
        appleManager = AppleAuthorizationUsecase(endPoint: EndPoint(urlConfigure: GitURLConfiguration(), method: .POST, body: nil), presentationAnchor: self.view.window) { [weak self] isVerified in
            guard isVerified == true else { return }
            self?.presentNextScene()
        }
        githubManager = GithubAuthorizationUsecase(endPoint: EndPoint(urlConfigure: GitURLConfiguration(), method: .POST, body: nil)) {[weak self]  isVerified in
            guard isVerified == true else { return }
            self?.presentNextScene()
        }
    }

    func presentNextScene() {
        let nextViewController = TabBarViewController()
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true)
    }

    func setViewsConstraint() {
        view.addSubViews(titleLabel, loginInputView, oauthLoginView)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.2),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 72),

            loginInputView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 72),
            loginInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginInputView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.2),

            oauthLoginView.topAnchor.constraint(equalTo: loginInputView.bottomAnchor),
            oauthLoginView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            oauthLoginView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            oauthLoginView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

}
