//
//  IssueCard.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import Foundation

// MARK: - Empty
struct IssueCardArrayDTO: Codable {
    let issues: [IssueCardDTO]
}

// MARK: - Issue
struct IssueCardDTO: Codable {
    let issueID: Int
    let title, content: String
    let milestoneID: Int
    let milestoneName: String
    let labels: [LabelDTO]

    enum CodingKeys: String, CodingKey {
        case issueID = "issueId"
        case title, content
        case milestoneID = "milestoneId"
        case milestoneName, labels
    }
}

// MARK: - Label
struct LabelDTO: Codable {
    let labelID: Int?
    let labelName, labelColor: String

    enum CodingKeys: String, CodingKey {
        case labelID = "labelId"
        case labelName, labelColor
    }
}

extension IssueCardDTO {

    func toDomain() -> IssueCardEntity {
        return .init(id: issueID, title: title, content: content, isSelected: false, mileStone: milestoneName, labels: labels.map { $0.toDomain() })
    }
}

extension LabelDTO {

    func toDomain() -> LabelEntity {
        return .init(id: labelID, labelName: labelName, labelColor: labelColor)
    }
}
