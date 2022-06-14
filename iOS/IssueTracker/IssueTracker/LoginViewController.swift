//
//  ViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/13.
//

import UIKit

class LoginViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .italicSystemFont(ofSize: 48)
        label.text = "Issue Tracker"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setViewsConstraint()
    }
}

private extension LoginViewController {
    
    func setViewsConstraint() {
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.2),
        ])
    }
}
