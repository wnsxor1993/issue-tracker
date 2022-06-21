//
//  ListView.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

class ListView: UIView {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
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
}

private extension ListView {

    func registerTableView() {
        listTableView.register(ListCell.self, forCellReuseIdentifier: ListCell.cellIdentifier)
    }

    func setConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubViews(titleLabel, listTableView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            listTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            listTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
