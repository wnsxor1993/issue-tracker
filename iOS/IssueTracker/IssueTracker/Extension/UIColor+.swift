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
