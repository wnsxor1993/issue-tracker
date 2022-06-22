//
//  NavigationItemView.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import UIKit

class NavigationButtonItem: UIButton {

    enum NavigationItemType: String {
        case filter = "line.3.horizontal.decrease"
        case select = "checkmark.circle"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(_ title: String, _ type: NavigationItemType) {
        self.init(frame: .zero)
        setImage(UIImage(systemName: type.rawValue), for: .normal)
        setTitle(title, for: .normal)
        setStyle(type: type)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

}

private extension NavigationButtonItem {

    func setStyle(type: NavigationItemType) {
        backgroundColor = .clear
        self.frame = CGRect(x: 0, y: 0, width: 70, height: 32)
        setTitleColor(.systemBlue, for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        if type == .select {
            semanticContentAttribute = .forceRightToLeft
            titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        }
    }

}
