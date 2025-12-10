//
//  Notification.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import Foundation

struct Notification {
    let id: UUID
    let userId: UUID
    let type: NotificationType
    let title: String
    let body: String
    let isRead: Bool
    let createdAt: Date
}

enum NotificationType {
    case newQuestion
    case allAnswered
    case answerRequest
    case treeGrowth
    case badgeEarned
}
