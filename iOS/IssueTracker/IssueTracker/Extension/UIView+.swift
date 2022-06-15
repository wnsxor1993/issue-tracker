//
//  UIView+.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/14.
//

import UIKit

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
