//
//  IssueCard.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import Foundation

struct IssueCardDTO: Identifiable {
    let id: Int
    let title: String
    let content: String
    let isSelected: Bool
    let mileStone: String?
    let labels: [Label]
}

struct Label: Identifiable {
    let id: Int
    let labelName: String
    let labelColor: String
}
