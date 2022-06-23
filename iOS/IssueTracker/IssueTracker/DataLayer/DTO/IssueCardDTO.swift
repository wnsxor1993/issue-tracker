//
//  IssueCard.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import Foundation

struct IssueCardDTO {
    let title: String
    let content: String
    let isSelected: Bool
    let mileStone: String?
    let label: String?
    let labelColor: String?
}
