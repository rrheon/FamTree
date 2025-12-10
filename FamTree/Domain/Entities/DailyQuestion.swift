//
//  DailyQuestion.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import Foundation

struct DailyQuestion {
    let id: UUID
    let familyId: UUID
    let questionId: UUID
    let date: Date // 질문이 주어진 날짜
    let isCompleted: Bool // 모든 구성원이 답변 완료했는지
    let answers: [Answer]
}
