//
//  IssueCardEntity.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/30.
//

import Foundation

struct IssueCardEntity: Identifiable {
    let id: Int
    let title: String
    let content: String
    let isSelected: Bool
    let mileStone: String?
    let labels: [LabelEntity]
}

struct LabelEntity: Identifiable {
    let id: Int
    let labelName: String
    let labelColor: String
}
