//
//  Question.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import Foundation

struct Question {
    let id: UUID
    let content: String
    let category: QuestionCategory
    let order: Int
    let createdAt: Date
}

enum QuestionCategory: String {
    case daily = "일상 & 취미"
    case memory = "추억 & 과거"
    case values = "가치관 & 생각"
    case future = "미래 & 계획"
    case gratitude = "감사 & 애정" 
}
