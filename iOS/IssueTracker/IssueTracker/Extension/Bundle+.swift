//
//  Bundle+.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/16.
//

import Foundation

extension Bundle {

    static func searchObject(from plist: String, key: String) -> String? {
        guard let filePath = main.path(forResource: plist, ofType: "plist") else {return nil}
        let plist = NSDictionary(contentsOfFile: filePath)
        let value = plist?.object(forKey: "gitClient_ID") as? String
        return  value == nil ? nil : value
    }

}
