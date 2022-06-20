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
        button.setImageWithTitle(imageName: .gitImage, title: .gitTitle)

        return button
    }()

    private let appleLoginButton: OAuthLoginButton = {
        let button = OAuthLoginButton()
        button.setImageWithTitle(imageName: .appleImage, title: .appleTitle)

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

    func getStackViewAttributes(subviews: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }

    func setConstraints() {
        let buttonStack = getStackViewAttributes(subviews: [appleLoginButton, githubLoginButton])
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
            self.delegate?.didClickAppleButton()
        })
        let gitHubAction = UIAction(handler: { _ in
            self.delegate?.didClickGitHubButton()
        })

        if #available(iOS 14.0, *) {
            appleLoginButton.addAction(appleAction, for: .touchDown)
            githubLoginButton.addAction(gitHubAction, for: .touchDown)
        } else {
            appleLoginButton.addTarget(self, action: #selector(touchedAppleButton), for: .touchDown)
            githubLoginButton.addTarget(self, action: #selector(touchedGitHubButton), for: .touchDown)
        }
    }

    @objc
    func touchedAppleButton() {
        self.delegate?.didClickAppleButton()
    }

    @objc
    func touchedGitHubButton() {
        self.delegate?.didClickGitHubButton()
    }
}
