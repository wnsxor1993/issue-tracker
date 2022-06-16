//
//  OAuthLoginButton.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/14.
//

import UIKit

class OAuthLoginButton: UIButton {
    
    enum ButtonImage: String {
        case gitImage = "github"
        case appleImage = "apple"
        
        func getRawValue() -> String {
            return self.rawValue
        }
    }
    
    enum ButtonTitle: String {
        case gitTitle = "GitHub 계정으로 로그인"
        case appleTitle = "Apple 계정으로 로그인"
        
        func getRawValue() -> String {
            return self.rawValue
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
    
    func setImageWithTitle(imageName: ButtonImage, title: ButtonTitle) {
        let image = UIImage(named: imageName.getRawValue())?.resizeWithHeighScale(height: 24)
        self.setTitle(title.getRawValue(), for: .normal)
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
