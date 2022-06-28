//
//  ViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/13.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {

    var loginVM: LoginViewModel?

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
        setViewModel()
        setViewsConstraint()
        setLoginViewModelBinding()
        oauthLoginView.delegate = self

    }
}

extension LoginViewController: OAuthButtonDelegate {
    func didClick(buttonType: OAuth) {
        loginVM?.enquireGrant(buttonCase: buttonType)
    }
}

private extension LoginViewController {

    func setViewModel() {
        self.loginVM = LoginViewModel(nil, AppleAuthorizationUsecase(presentationAnchor: self.view.window))
    }

    func setLoginViewModelBinding() {
        loginVM?.userInfo.bind { info in
            guard let userInfo = info else { return }
            print(userInfo)
            self.presentNextScene()
        }

        loginVM?.gitOAuthPageURL.bind { url in
            guard let usefulURL = url, UIApplication.shared.canOpenURL(usefulURL) else { return }
            UIApplication.shared.open(usefulURL)
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
