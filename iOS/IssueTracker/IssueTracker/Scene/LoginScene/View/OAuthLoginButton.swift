//
//  OAuthLoginButton.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/14.
//

import UIKit

class OAuthLoginButton: UIButton {

    private(set) var oauthButtonType: OAuthButtonType?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setAllAttributes()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configureOAuthButton(with buttonType: OAuthButtonType) {
        self.oauthButtonType = buttonType
        let image = UIImage(named: buttonType.image)?.resizeWithHeighScale(height: 24)
        self.setTitle(buttonType.title, for: .normal)
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
