//
//  OAuthLoginButton.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/14.
//

import UIKit

class OAuthLoginButton: UIButton {

    enum ButtonName {
        case gitImage
        case gitTitle
        case appleImage
        case appleTitle

        var description: String {
            switch self {
            case .gitImage:
                return "github"
            case .gitTitle:
                return "GitHub 계정으로 로그인"
            case .appleImage:
                return "apple"
            case .appleTitle:
                return "Apple 계정으로 로그인"
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setAllAttributes()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setImageWithTitle(imageName: ButtonName, title: ButtonName) {
        let image = UIImage(named: imageName.description)?.resizeWithHeighScale(height: 24)
        self.setTitle(title.description, for: .normal)
        self.setImage(image, for: .normal)
    }
}

private extension OAuthLoginButton {

    func setAllAttributes() {
        setLayerAttribute()
        setTitleViewAttribute()
        setImageViewAttribute()
        setContentAttribute()
    }

    func setLayerAttribute() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 20
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func setTitleViewAttribute() {
        self.setTitleColor(UIColor.oauthLoginButton, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    }

    func setImageViewAttribute() {
        self.imageView?.contentMode = .scaleAspectFit
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16)
    }

    func setContentAttribute() {
        self.contentHorizontalAlignment = .center
        self.semanticContentAttribute = .forceLeftToRight
    }
}
