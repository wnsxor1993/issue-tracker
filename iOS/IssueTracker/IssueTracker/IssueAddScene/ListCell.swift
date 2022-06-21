//
//  ListCell.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

class ListCell: UICollectionViewCell {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.529, green: 0.529, blue: 0.553, alpha: 1)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var arrowLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.529, green: 0.529, blue: 0.553, alpha: 1)
        label.text = ">"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configureCellText(title: String, value: String) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
}

private extension ListCell {

    func setConstraints() {
        self.addSubViews(titleLabel, valueLabel, arrowLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            arrowLabel.topAnchor.constraint(equalTo: self.topAnchor),
            arrowLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            arrowLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            arrowLabel.heightAnchor.constraint(equalToConstant: 30),
            
            valueLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: arrowLabel.leadingAnchor),
            valueLabel.topAnchor.constraint(equalTo: self.topAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
