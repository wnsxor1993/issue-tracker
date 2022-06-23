//
//  selectionLabel.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import UIKit

class SelectionImageView: UIImageView {

    var isSelected: Bool = false {
        didSet {
            self.isHidden = !isSelected
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let image = UIImage(systemName: "checkmark.circle.fill")
        self.contentMode = .scaleAspectFit
        self.image = image
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
