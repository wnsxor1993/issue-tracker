//
//  DefaultIssueCardRepository.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/30.
//

import Foundation

protocol ViewIssueCardRepository {
    var endPoint: EndPoint {get}
    func fetchIssueCard(completion: @escaping (IssueCardArrayDTO?) -> Void)
}
