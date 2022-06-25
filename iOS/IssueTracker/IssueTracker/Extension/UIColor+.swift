//
//  UIColor+.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/15.
//

import UIKit

extension UIColor {
    class var issueTrackerGray1: UIColor? { return UIColor(named: "LoginBackground") ?? UIColor.systemGray }
    class var issueTrackerGray2: UIColor? { return UIColor(named: "DividedLine") ?? UIColor.systemGray2 }
    class var issueTrackerGray3: UIColor? { return UIColor(named: "IssueAddText") ?? UIColor.gray }
    class var issueTrackerBlue: UIColor? { return UIColor(named: "LogSignInButton") ?? UIColor.systemBlue }
    class var issueTrackerWhite: UIColor? { return UIColor(named: "OAuthLoginButton") ?? UIColor.black }
}

extension UIColor {

    static func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if (cString.count) != 6 {
            return UIColor.gray
        }

        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
