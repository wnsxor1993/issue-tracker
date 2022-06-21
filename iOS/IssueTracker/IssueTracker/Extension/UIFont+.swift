//
//  UIFont+.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import UIKit

extension UIFont {

    static var largeRegular: UIFont {
        return UIFont.systemFont(ofSize: 34, weight: .regular)
    }

    static var mediumRegular: UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .medium)
    }

    static var smallRegular: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .regular)
    }

    static var largeBold: UIFont {
        return UIFont.systemFont(ofSize: 34, weight: .semibold)
    }

    static var mediumBold: UIFont {
        return UIFont.systemFont(ofSize: 22, weight: .semibold)
    }

    static var smallBold: UIFont {
        return UIFont.systemFont(ofSize: 17, weight: .semibold)
    }

    static var caption: UIFont {
        return UIFont.systemFont(ofSize: 12, weight: .semibold)
    }
}
