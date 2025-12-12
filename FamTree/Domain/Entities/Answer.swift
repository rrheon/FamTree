//
//  Answer.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import Foundation

struct Answer {
    let id: UUID
    let dailyQuestionId: UUID
    let userId: UUID
    let content: String
    let imageURL: String?
    let createdAt: Date
}
