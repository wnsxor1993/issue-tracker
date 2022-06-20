//
//  TabBarViewController.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/20.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDisplay()
        configureLayout()
    }

    private func configureDisplay () {
        let homeViewController =  UINavigationController(rootViewController: HomeViewController())
        let labelViewController = UIViewController()
        let mileStoneViewController = UIViewController()
        let issueTabItem = UITabBarItem(title: "이슈", image: UIImage(named: "exclamationmark.circle"), tag: 0)
        let labelTabItem = UITabBarItem(title: "레이블", image: UIImage(named: "tag.fill"), tag: 1)
        let mileStoneTabItem = UITabBarItem(title: "마일스톤", image: UIImage(named: "signpost.right"), tag: 2)

        labelViewController.view.backgroundColor = .lightGray
        mileStoneViewController.view.backgroundColor = .systemGreen
        homeViewController.tabBarItem = issueTabItem
        labelViewController.tabBarItem = labelTabItem
        mileStoneViewController.tabBarItem = mileStoneTabItem
        setViewControllers([homeViewController, labelViewController, mileStoneViewController], animated: false)
        tabBar.backgroundColor = .white
        tabBar.tintColor = .secondarySystemBackground
    }

    private func configureLayout() {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1))
        lineView.backgroundColor = .secondarySystemBackground
        tabBar.addSubview(lineView)
    }

}
