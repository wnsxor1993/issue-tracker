//
//  DefaultShowingIssueCardUsecase.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/30.
//

import Foundation

protocol ViewIssueCardUsecase {

    var fetchIssueCardRepository: ViewIssueCardRepository { get }
    func execute(completion: @escaping ([IssueCardEntity]) -> Void)
}
