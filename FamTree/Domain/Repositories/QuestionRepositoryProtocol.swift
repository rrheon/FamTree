//
//  QuestionRepositoryProtocol.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import Foundation

protocol QuestionRepositoryProtocol {
    func getTodayQuestion() async throws -> Question?
    func getQuestion(id: UUID) async throws -> Question?
    func getQuestionHistory(familyId: UUID, page: Int, limit: Int) async throws -> [Question]
}

enum QuestionError: Error, Equatable {
    case questionNotFound
    case noQuestionToday
    case networkError
    case unknown(String)

    var localizedDescription: String {
        switch self {
        case .questionNotFound:
            return "질문을 찾을 수 없습니다."
        case .noQuestionToday:
            return "오늘의 질문이 아직 없습니다."
        case .networkError:
            return "네트워크 연결을 확인해주세요."
        case .unknown(let message):
            return message
        }
    }
}
