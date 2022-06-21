//
//  IssuseCardCell.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import UIKit

class IssuseCardCell: UICollectionViewCell {

    private var title: UILabel = {
        let label = UILabel()
        label.font = .mediumBold
        label.text = "test 이슈 타이틀"
        return label
    }()

    private var selectionLabel: UIImageView = {
        var imageView = UIImageView()
        let image = UIImage(systemName: "checkmark.circle.fill")
//        imageView.isHidden =  true
        return imageView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, selectionLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    private var content: UILabel = {
        let label = UILabel()
        label.font = .smallRegular
        label.textColor = .systemGray
        label.text = "issue 내용입니다"
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
        label.text = "mileStoneTextTest"
        return label
    }()
    
    private lazy var mileStoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mileStoneImageView, mileStoneLabel])
        stackView.axis = .horizontal
//        stackView.isHidden = true
        return stackView
    }()
    
    private var badgeLabel: BadgeLabel = {
        let badge = BadgeLabel()
        return badge
    }()
    
    private lazy var cellContianerStackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [titleStackView,content, mileStoneStackView,badgeLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cellContianerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            cellContianerStackView.leftAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cellContianerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    

    
}
