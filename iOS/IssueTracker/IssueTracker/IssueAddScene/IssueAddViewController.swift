//
//  IssueAddViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

final class IssueAddViewController: UIViewController {

    private var commentView = CommentView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setConstraints()
    }
}

private extension IssueAddViewController {

    func setNavigationBar() {
        let rightBarButton = UIBarButtonItem(title: "저장 +", style: .plain, target: self, action: nil)
        self.navigationController?.navigationItem.rightBarButtonItem = rightBarButton
    }

    func setConstraints() {
        self.view.addSubViews(commentView)

        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            commentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            commentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7)
        ])
    }
}
