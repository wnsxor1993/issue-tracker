//
//  DefaultShowingIssueCardUsecase.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/30.
//

import Foundation

protocol DefaultIssueCardUsecase {
    associatedtype T

    var fetchIssueCardRepository: DefaultIssueCardRepository { get }
    func execute(completion: @escaping (T) -> Void)
}
