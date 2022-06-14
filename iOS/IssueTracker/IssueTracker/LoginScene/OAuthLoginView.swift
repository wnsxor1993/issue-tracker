//
//  OAuthLoginView.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/14.
//

import UIKit

class OAuthLoginView: UIView {

    private let githubLoginButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "github")?.resizeImage(height: 24)
        button.backgroundColor = .black
        button.setTitle("GitHub 계정으로 로그인", for: .normal)
        button.setTitleColor(UIColor(red: 0.996, green: 0.996, blue: 0.996, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        button.contentHorizontalAlignment = .center
        button.semanticContentAttribute = .forceLeftToRight
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let appleLoginButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "apple")?.resizeImage(height: 24)
        button.backgroundColor = .black
        button.setTitle("Apple 계정으로 로그인", for: .normal)
        button.setTitleColor(UIColor(red: 0.996, green: 0.996, blue: 0.996, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
        button.contentHorizontalAlignment = .center
        button.semanticContentAttribute = .forceLeftToRight
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setConstraints()
        setButtonCornerRadius()
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
    
    func setButtonCornerRadius() {
        githubLoginButton.layer.cornerRadius = 20
        appleLoginButton.layer.cornerRadius = 20
    }
}
