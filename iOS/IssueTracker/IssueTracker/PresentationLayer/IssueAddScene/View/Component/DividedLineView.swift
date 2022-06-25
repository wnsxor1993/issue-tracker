//
//  DividedLineView.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/21.
//

import UIKit

final class DividedLineView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .issueTrackerGray2
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}
