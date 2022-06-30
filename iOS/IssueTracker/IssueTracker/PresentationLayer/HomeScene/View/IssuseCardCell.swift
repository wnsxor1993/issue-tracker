//
//  IssuseCardCell.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import UIKit

class IssuseCardCell: UITableViewCell {

    static let id = "IssuseCardCell"

    private var title: UILabel = {
        let label = UILabel()
        label.font = .mediumBold
        return label
    }()

    private var selectionImageView: SelectionImageView = {
        let label = SelectionImageView(frame: .zero)
        return label
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, selectionImageView])
        stackView.axis = .horizontal
        return stackView
    }()

    private var content: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .systemGray
        label.numberOfLines = 2
        return label
    }()

    private var mileStoneImageView: UIImageView = {
        var imageView = UIImageView()
        let image = UIImage(systemName: "signpost.right")
        imageView.image = image
        return imageView
    }()

    private var mileStoneLabel: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .systemGray
        return label
    }()

    private lazy var mileStoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mileStoneImageView, mileStoneLabel])
        stackView.axis = .horizontal
        return stackView
    }()

//    private var badgeLabel: BadgeLabel = {
//        let badge = BadgeLabel()
//        return badge
//    }()

    private lazy var badgeLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally

        return stackView
    }()

    private lazy var cellContianerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleStackView, content, mileStoneStackView])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        contentView.addSubview(cellContianerStackView)
        contentView.addSubview(badgeLabelStackView)
        NSLayoutConstraint.activate([
            cellContianerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            cellContianerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellContianerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            badgeLabelStackView.topAnchor.constraint(equalTo: cellContianerStackView.bottomAnchor, constant: 16),
            badgeLabelStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            badgeLabelStackView.leadingAnchor.constraint(equalTo: cellContianerStackView.leadingAnchor)
        ])
    }

}

extension IssuseCardCell {

    func configure(model: IssueCardEntity) {
        title.text = model.title
        content.text =  model.content
        selectionImageView.isSelected = model.isSelected
        mileStoneLabel.text =  model.mileStone
        model.labels.forEach({
            let badgeLabel = BadgeLabel()
            badgeLabel.configure($0.labelName, hexColor: $0.labelColor)
            badgeLabelStackView.addArrangedSubview(badgeLabel)
        })

        if mileStoneLabel.text == nil {
            mileStoneStackView.isHidden = true
        }
    }

    func selected() {
        selectionImageView.isSelected = !selectionImageView.isSelected
    }
}
