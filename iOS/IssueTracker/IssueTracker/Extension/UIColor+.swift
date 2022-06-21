//
//  UIColor+.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/15.
//

import UIKit

extension UIColor {
    class var loginBackground: UIColor? { return UIColor(named: "LoginBackground") ?? UIColor.systemGray }
    class var logSignInButton: UIColor? { return UIColor(named: "LogSignInButton") ?? UIColor.systemBlue }
    class var oauthLoginButton: UIColor? { return UIColor(named: "OAuthLoginButton") ?? UIColor.black }
    class var dividedLine: UIColor? { return UIColor(named: "DividedLine") ?? UIColor.systemGray2 }
}

extension UIColor {

    convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }

}
