//
//  FetchIssueCardUsecase.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/30.
//

import Foundation

final class FetchOpenIssueCardUsecase: FetchIssueCardUsecase {

    private(set) var fetchIssueCardRepository: DefaultIssueCardRepository

    init(repository: DefaultIssueCardRepository = FetchIssueCardRepository()) {
        self.fetchIssueCardRepository = repository
    }

    func execute(completion: @escaping ([IssueCardEntity]) -> Void) {
        fetchIssueCardRepository.fetchIssueCard { issueCards in
            guard let issueCards = issueCards else { return }

            let issueEntities: [IssueCardEntity] = issueCards.issues.map { $0.toDomain() }
            completion(issueEntities)
        }
    }
}
