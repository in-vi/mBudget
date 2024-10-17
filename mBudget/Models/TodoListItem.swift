//
//  TodoListItem.swift
//  mBudget
//
//  Created by Ranjith Palle on 2024/10/13.
//

import Foundation

struct TodoListItem: Codable, Identifiable {
    let id: String
    let title: String
    let date: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    let amount: String
    let category: Category  // Add category to the item

    mutating func setDone(_ state: Bool) {
        isDone = state
    }
}

