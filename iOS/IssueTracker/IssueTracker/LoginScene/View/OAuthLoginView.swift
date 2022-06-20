//
//  OAuthLoginView.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/14.
//

import UIKit

class OAuthLoginView: UIView {

    var delegate: OAuthButtonDelegate?

    private let githubLoginButton: OAuthLoginButton = {
        let button = OAuthLoginButton()
        button.configureOAuthButton(with: .git)

        return button
    }()

    private let appleLoginButton: OAuthLoginButton = {
        let button = OAuthLoginButton()
        button.configureOAuthButton(with: .apple)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setConstraints()
        setOAuthButtonAction()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension OAuthLoginView {

    func stackView(withSubviews subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    func setConstraints() {
        let buttonStack = stackView(withSubviews: [appleLoginButton, githubLoginButton])
        addSubview(buttonStack)

        NSLayoutConstraint.activate([
            buttonStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            buttonStack.heightAnchor.constraint(equalToConstant: 126),
            buttonStack.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    func setOAuthButtonAction() {
        let appleAction = UIAction(handler: { _ in
            self.delegate?.didClick(buttonType: .apple)
        })
        let gitHubAction = UIAction(handler: { _ in
            self.delegate?.didClick(buttonType: .git)
        })

        if #available(iOS 14.0, *) {
            appleLoginButton.addAction(appleAction, for: .touchDown)
            githubLoginButton.addAction(gitHubAction, for: .touchDown)
        } else {
            appleLoginButton.addTarget(self, action: #selector(touchedOAuthButton), for: .touchDown)
            githubLoginButton.addTarget(self, action: #selector(touchedOAuthButton), for: .touchDown)
        }
    }

    @objc
    func touchedOAuthButton(_ sender: OAuthLoginButton) {
        guard let type = sender.oauthButtonType else { return }
        self.delegate?.didClick(buttonType: type)
    }
}
