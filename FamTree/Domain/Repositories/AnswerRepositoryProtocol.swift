//
//  AnswerRepositoryProtocol.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import Foundation

protocol AnswerRepositoryProtocol {
    func submitAnswer(questionId: UUID, userId: UUID, content: String) async throws -> Answer
    func getAnswer(id: UUID) async throws -> Answer?
    func getAnswers(questionId: UUID, familyId: UUID) async throws -> [Answer]
    func getUserAnswer(questionId: UUID, userId: UUID) async throws -> Answer?
    func updateAnswer(id: UUID, content: String) async throws -> Answer
    func deleteAnswer(id: UUID) async throws
    func checkAllMembersAnswered(questionId: UUID, familyId: UUID) async throws -> Bool
}

enum AnswerError: Error, Equatable {
    case answerNotFound
    case alreadyAnswered
    case cannotModify
    case networkError
    case unknown(String)

    var localizedDescription: String {
        switch self {
        case .answerNotFound:
            return "답변을 찾을 수 없습니다."
        case .alreadyAnswered:
            return "이미 답변을 작성했습니다."
        case .cannotModify:
            return "답변을 수정할 수 없습니다."
        case .networkError:
            return "네트워크 연결을 확인해주세요."
        case .unknown(let message):
            return message
        }
    }
}
