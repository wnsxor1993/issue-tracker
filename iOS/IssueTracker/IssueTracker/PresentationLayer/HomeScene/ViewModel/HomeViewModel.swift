//
//  HomeViewModel.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/30.
//

import Foundation

final class HomeViewModel {

    private var fetchOpenIssueCardUsecase: ViewIssueCardUsecase

    var issueCards: Observable<[IssueCardEntity]?> = Observable(nil)

    init(fetchIssueUsecase: ViewIssueCardUsecase = ViewFilteredIssueCardUsecase()) {
        self.fetchOpenIssueCardUsecase = fetchIssueUsecase
    }

    func fetchIssueCards() {
        fetchOpenIssueCardUsecase.execute { issueCards in
            self.issueCards.updateValue(value: issueCards)
        }
    }
}
