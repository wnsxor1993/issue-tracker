//
//  IssueCard.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import Foundation

// MARK: - Empty
struct Empty: Codable {
    let issues: [IssueCard]
}

// MARK: - Issue
struct IssueCard: Codable {
    let issueID: Int
    let title, content: String
    let milestoneID: Int
    let milestoneName: String
    let labels: [Label]

    enum CodingKeys: String, CodingKey {
        case issueID = "issueId"
        case title, content
        case milestoneID = "milestoneId"
        case milestoneName, labels
    }
}

// MARK: - Label
struct Label: Codable {
    let labelID: Int?
    let labelName, labelColor: String

    enum CodingKeys: String, CodingKey {
        case labelID = "labelId"
        case labelName, labelColor
    }
}

extension IssueCard {

    func toDomain() -> IssueCardEntity {
        return .init(id: issueID, title: title, content: content, isSelected: false, mileStone: milestoneName, labels: labels.map { $0.toDomain() })
    }
}

extension Label {

    func toDomain() -> LabelEntity {
        return .init(id: labelID, labelName: labelName, labelColor: labelColor)
    }
}
