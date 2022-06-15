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
    
    func setConstraints() {
        addSubViews(githubLoginButton, appleLoginButton)
        
        NSLayoutConstraint.activate([
            appleLoginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            appleLoginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            appleLoginButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 56),
            
            githubLoginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            githubLoginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            githubLoginButton.bottomAnchor.constraint(equalTo: appleLoginButton.topAnchor, constant: -14),
            githubLoginButton.heightAnchor.constraint(equalToConstant: 56)
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
