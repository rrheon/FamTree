//
//  Notification.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import Foundation

public struct Notification: Equatable, Sendable {
    public let id: UUID
    public let userId: UUID
    public let type: NotificationType
    public let title: String
    public let body: String
    public let isRead: Bool
    public let createdAt: Date

    public init(
        id: UUID,
        userId: UUID,
        type: NotificationType,
        title: String,
        body: String,
        isRead: Bool,
        createdAt: Date
    ) {
        self.id = id
        self.userId = userId
        self.type = type
        self.title = title
        self.body = body
        self.isRead = isRead
        self.createdAt = createdAt
    }
}

public enum NotificationType: Sendable, Equatable {
    case newQuestion
    case allAnswered
    case answerRequest
    case treeGrowth
    case badgeEarned
}
