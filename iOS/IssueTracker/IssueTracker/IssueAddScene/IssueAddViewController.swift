//
//  IssueAddViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

final class IssueAddViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
    }
}

private extension IssueAddViewController {

    func setNavigationBar() {
        let rightBarButton = UIBarButtonItem(title: "저장 +", style: .plain, target: self, action: nil)
        self.navigationController?.navigationItem.rightBarButtonItem = rightBarButton
    }
}
