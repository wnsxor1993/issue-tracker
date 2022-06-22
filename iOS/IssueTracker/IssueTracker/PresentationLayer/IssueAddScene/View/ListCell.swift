//
//  ListCell.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

final class ListCell: UITableViewCell {

    static let cellIdentifier = "IssueAddSceneListCell"

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .issueTrackerGray3
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var arrowLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .issueTrackerGray3
        label.text = ">"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configureCellText(title: String, value: String?) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
}

private extension ListCell {

    func setConstraints() {
        let titleLeadingConstant: CGFloat = 16
        let titleWidthRation: CGFloat = 0.3

        let arrowTrailingConstant: CGFloat = -16
        let arrowWidhtHeightConstant: CGFloat = 30

        self.addSubViews(titleLabel, valueLabel, arrowLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: titleLeadingConstant),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: titleWidthRation),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            arrowLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            arrowLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: arrowTrailingConstant),
            arrowLabel.heightAnchor.constraint(equalToConstant: arrowWidhtHeightConstant),
            arrowLabel.widthAnchor.constraint(equalToConstant: arrowWidhtHeightConstant),

            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: arrowLabel.leadingAnchor),
            valueLabel.topAnchor.constraint(equalTo: self.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
