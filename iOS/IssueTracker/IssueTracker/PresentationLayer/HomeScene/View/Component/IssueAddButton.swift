//
//  IssueAddButton.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/22.
//

import UIKit

class IssueAddButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButton() {
        self.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
        layer.cornerRadius = self.frame.width / 2
        translatesAutoresizingMaskIntoConstraints = false
    }

}
