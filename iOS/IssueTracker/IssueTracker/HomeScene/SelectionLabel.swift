//
//  selectionLabel.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import UIKit

class SelectionLabel: UILabel {

    var isSelected: Bool = false {
        didSet {
            selectionImageView.isHidden = isSelected
        }
    }

    private var selectionImageView: UIImageView = {
        var imageView = UIImageView()
        let image = UIImage(systemName: "checkmark.circle.fill")
        imageView.isHidden = false
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
