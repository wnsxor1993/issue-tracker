//
//  HomeViewController.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/20.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        setNavigation()
        setDataSource()
    }

}

private extension HomeViewController {

    func setNavigation() {
        let filterBarItem = UIBarButtonItem(customView: NavigationButtonItem("필터", .filter))
        let selectBarItem = UIBarButtonItem(customView: NavigationButtonItem("선택", .select))
        navigationItem.leftBarButtonItem = filterBarItem
        navigationItem.rightBarButtonItem = selectBarItem
        navigationItem.title = "이슈"
        navigationController?.navigationBar.prefersLargeTitles = true
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .black
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }

    func setDataSource() {
        CollectionViewDataSource<String, UICollectionViewCell>(["d", "d"], reuseIdentifier: "d") { _, _ in

        }
    }
}
