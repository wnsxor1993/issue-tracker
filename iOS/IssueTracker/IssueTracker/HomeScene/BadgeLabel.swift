//
//  BadgeLabel.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import UIKit

class BadgeLabel: UILabel {

    private var padding = UIEdgeInsets(top: 4, left: 8.0, bottom: 4, right: 8.0)

    func configure(_ text: String?, hexColor: String?) {
        guard let hexColor = hexColor, let text = text else {return}
        self.text = text
        self.backgroundColor = UIColor.hexStringToUIColor(hex: hexColor)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        styleConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func styleConfiguration() {
        clipsToBounds = true
        font = .caption
        layer.cornerRadius = self.font.pointSize * 1.8 / 2
        textColor = .white
        textAlignment = .center
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
