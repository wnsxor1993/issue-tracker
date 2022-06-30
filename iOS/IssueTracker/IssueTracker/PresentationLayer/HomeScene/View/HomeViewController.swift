//
//  HomeViewController.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/20.
//

import UIKit

class HomeViewController: UIViewController {

    private var homeTableView: UITableView?
    private var dataSource: TableViewDataSource<IssueCardEntity, IssuseCardCell>?
    private var issueCreateButton: IssueAddButton?

    let homeVM = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        configureDisplay()
        setDataBinding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

private extension HomeViewController {

    func configureDisplay() {
        setNavigation()
        setTableView()
        setDataSource()
        setAddButton()
        setConstraints()
    }

    func setNavigation() {
        let filterBarItem = UIBarButtonItem(customView: NavigationButtonItem("필터", .filter))
        let selectBarItem = UIBarButtonItem(customView: NavigationButtonItem("선택", .select))
        navigationItem.leftBarButtonItem = filterBarItem
        navigationItem.rightBarButtonItem = selectBarItem
        navigationItem.title = "이슈"
        navigationItem.backButtonTitle = "취소"
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .black
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }

    func setTableView() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(IssuseCardCell.self, forCellReuseIdentifier: IssuseCardCell.id)
        homeTableView = tableView
        homeTableView?.translatesAutoresizingMaskIntoConstraints = false
        homeTableView?.delegate = self

    }

    func setDataSource() {
        let dataSource = TableViewDataSource(homeVM.issueCards.value, reuseIdentifier: IssuseCardCell.id, cellConfigurator: { (model: IssueCardEntity, cell: IssuseCardCell) in
            cell.configure(model: model)
        })

        self.dataSource = dataSource
        homeTableView?.dataSource = dataSource
    }

    func setDataBinding() {
        homeVM.issueCards.bind {[weak self] issueCards in

            guard let issueCards = issueCards else {return}
            self?.dataSource?.updateData(issueCards)
            DispatchQueue.main.async {
                self?.homeTableView?.reloadData()
            }
        }
        homeVM.fetchIssueCards()
    }

    func setAddButton() {
        let button = IssueAddButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        issueCreateButton = button
        issueCreateButton?.addTarget(self, action: #selector(didTabIssueCreateButton), for: .touchUpInside)
    }

    @objc func didTabIssueCreateButton() {
        let issueAddVC = IssueAddViewController()
        self.navigationController?.pushViewController(issueAddVC, animated: true)
    }

    func setConstraints() {
        guard let homeTableView = homeTableView, let issueAddButton = issueCreateButton else {return}
        homeTableView.rowHeight = UITableView.automaticDimension
        homeTableView.estimatedRowHeight = 130
        view.addSubview(homeTableView)
        view.addSubview(issueAddButton)

        NSLayoutConstraint.activate([
            homeTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            homeTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            issueAddButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -issueAddButton.frame.height),
            issueAddButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -issueAddButton.frame.width),
            issueAddButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            issueAddButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
