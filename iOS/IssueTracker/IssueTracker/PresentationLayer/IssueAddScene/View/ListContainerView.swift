//
//  ListView.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

class ListContainerView: UIView {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .mediumBold
        label.text = "추가 정보"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private(set) var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        registerTableView()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func setDelegate(to viewController: UIViewController) {
        guard let vcDelegate = viewController as? UITableViewDelegate else { return }

        self.listTableView.delegate = vcDelegate
    }
}

private extension ListContainerView {

    func registerTableView() {
        listTableView.register(ListCell.self, forCellReuseIdentifier: ListCell.cellIdentifier)
    }

    func setConstraints() {
        let titleTopConstant: CGFloat = 18
        let titleLeadingConstant: CGFloat = 16
        let listTopConstant: CGFloat = 8

        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubViews(titleLabel, listTableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: titleTopConstant),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: titleLeadingConstant),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            listTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: listTopConstant),
            listTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
