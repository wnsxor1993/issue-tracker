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

    private(set) var listCollectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension ListView {

    func setConstraints() {
        self.addSubViews(titleLabel, listCollectionView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            listCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            listCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
