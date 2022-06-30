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
        homeVM.issueCards.bind { issueCards in
            // 관련 작업
        }
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
        setDataBinding()
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
//
//        let labels1 = [Label(id: 2, labelName: "이것의 끝은 어디인가", labelColor: "#020070"), Label(id: 3, labelName: "북치고 장구치기 낄낄", labelColor: "#FF3B30")]
//
//        let labels2 = [Label(id: 2, labelName: "이것의 끝은 어디인가", labelColor: "#020070"), Label(id: 3, labelName: "북치고 장구치기 낄낄", labelColor: "#FF3B30"), Label(id: 3, labelName: "이것의 끝은 dddd어디인가", labelColor: "#020070"), Label(id: 3, labelName: "북치고 장구치기 낄낄", labelColor: "#FF3B30"), Label(id: 4, labelName: "이것의 끝은 어디ds인가", labelColor: "#020070"), Label(id: 3, labelName: "북치고 장구치기 낄낄", labelColor: "#FF3B30")]
//
        let mockEntity = IssueCardEntity(id: 2, title: "dasd", content: "Asdd", isSelected: false, mileStone: "asdsad", labels: [LabelEntity(id: 2, labelName: "dsd", labelColor: "asdasd")])
//
//        let mockEntity2 = IssueCardDTO(id: 2, title: "야호", content: "이건 우리안의 소리  연결고리연결고리연결고리연결고리연결고리연결고리 이건 우리안의 소리 ", isSelected: true, mileStone: nil, labels: labels2)
//
        var testData = [mockEntity]

        let dataSource = TableViewDataSource(testData, reuseIdentifier: IssuseCardCell.id, cellConfigurator: { (model: IssueCardEntity, cell: IssuseCardCell) in
            cell.configure(model: model)
        })

        self.dataSource = dataSource
        homeTableView?.dataSource = dataSource
    }

    func setDataBinding() {
        // MARK: TO BE IMPLEMENTED WITH VIEWMODEL
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
