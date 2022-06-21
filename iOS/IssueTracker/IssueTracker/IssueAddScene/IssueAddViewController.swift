//
//  IssueAddViewController.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

final class IssueAddViewController: UIViewController {

    private var commentView = CommentView()
    private var listView = ListView()

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
        self.view.addSubViews(commentView, listView)

        NSLayoutConstraint.activate([
            commentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            commentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            commentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            commentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.7),

            listView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            listView.topAnchor.constraint(equalTo: commentView.bottomAnchor),
            listView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

    func setInnerPropertyDelegate() {
        self.listView.listCollectionView.delegate = self
    }
}

extension IssueAddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
