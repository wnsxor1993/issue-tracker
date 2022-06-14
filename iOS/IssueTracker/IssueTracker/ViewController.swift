//
//  ViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/13.
//

import UIKit

class ViewController: UIViewController {

    private lazy var loginInputView: LoginInputView = {
        let view = LoginInputView(frame: view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 48)
        label.text = "Issue Tracker"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        setViewsConstraint()
        let test = OauthNetworkManager(endPoint: OauthEndPoint<GitAuthentication>(),serivce: OauthNetworkService())
        test.enquireForGrant()
    }
}

private extension ViewController {
    
    func setViewsConstraint() {
        view.addSubViews(titleLabel, loginInputView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.2),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 72),
            
            loginInputView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 72),
            loginInputView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loginInputView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loginInputView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.2)
        ])
    }
}
