//
//  ViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/13.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {

    private lazy var appleManager: OAuthManageable = AppleManager(endPoint: EndPoint(urlConfigure: GitURLConfiguration(), method: .POST, body: nil), presentationAnchor: self.view.window)

    private var githubManager: OAuthManageable = GitHubManager(endPoint: EndPoint(urlConfigure: GitURLConfiguration(), method: .POST, body: nil))

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
        view.backgroundColor = .loginBackground
        setViewsConstraint()
        setOAuthObserver()
        oauthLoginView.delegate = self
    }
}

extension LoginViewController: OAuthButtonDelegate {
    func didClick(buttonType: OAuthButtonType) {
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

    func setOAuthObserver() {
        let responseHandler: ((Bool) -> Void) = { isVerified in
            guard isVerified == true else { return }
            print(isVerified)
            let nextViewController = TabBarViewController()
            nextViewController.modalPresentationStyle = .fullScreen
            self.present(nextViewController, animated: true)
        }

        self.appleManager.observe(responseHandler: responseHandler)
        self.githubManager.observe(responseHandler: responseHandler)
    }
}
