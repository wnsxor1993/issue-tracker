//
//  FetchIssueListURLConfiguration.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/30.
//

import Foundation

struct FetchOpenIssueListURLConfiguration: URLConfigurable {
    var scheme: String = "https"
    var host: String = "0e1f525b-4045-4a86-b2d7-b782850ccb9f.mock.pstmn.io"
    var path: String = "/issue-tracker/api/issues"
    var queryItem: [URLQueryItem]? =  [URLQueryItem(name: "isOpened", value: "true")]
}
//https://0e1f525b-4045-4a86-b2d7-b782850ccb9f.mock.pstmn.io/issue-tracker/api/issues?isOpened=true
//https://0e1f525b-4045-4a86-b2d7-b782850ccb9f.mock.pstmn.io/issue-tracker/api/issues%3FisOpened=true
