//
//  DefaultShowingIssueCardUsecase.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/30.
//

import Foundation

protocol FetchIssueCardUsecase {

    var fetchIssueCardRepository: DefaultIssueCardRepository { get }
    func execute(completion: @escaping ([IssueCardEntity]) -> Void)
}
