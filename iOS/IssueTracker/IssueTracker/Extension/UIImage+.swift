//
//  UIImage+.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/14.
//

import UIKit

extension UIImage {
    func resizeImage(height: CGFloat) -> UIImage? {
        let scale = height / self.size.height
        let width = self.size.width * scale
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
