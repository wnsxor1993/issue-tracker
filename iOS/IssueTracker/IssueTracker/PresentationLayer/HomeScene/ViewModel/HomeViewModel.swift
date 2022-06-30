//
//  HomeViewModel.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/30.
//

import Foundation

final class HomeViewModel {

    private var fetchOpenIssueCardUsecase: FetchIssueCardUsecase

    var issueCards: Observable<[IssueCardEntity]?> = Observable(nil)

    init(fetchIssueUsecase: FetchIssueCardUsecase = FetchOpenIssueCardUsecase()) {
        self.fetchOpenIssueCardUsecase = fetchIssueUsecase
    }

    func fetchIssueCards() {
        fetchOpenIssueCardUsecase.execute { issueCards in
            self.issueCards.updateValue(value: issueCards)
        }
    }
}
