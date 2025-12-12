//
//  User.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import Foundation

struct User {
    let id: UUID
    let email: String
    let name: String
    let profileImageURL: String?
    let role: FamilyRole // 아빠, 엄마, 아들, 딸 등
    let createdAt: Date
}

enum FamilyRole: String {
    case father = "아빠"
    case mother = "엄마"
    case son = "아들"
    case daughter = "딸"
    case other = "기타"
}
