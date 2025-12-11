//
//  Family.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import Foundation

struct Family: Equatable, Sendable {
    let id: UUID
    let name: String
    let members: [User]
    let createdBy: UUID // User ID
    let createdAt: Date
    let inviteCode: String
    let familyTree: FamilyTree
}

