//
//  FamilyRepositoryProtocol.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import Foundation

protocol FamilyRepositoryProtocol {
    func createFamily(name: String, userId: UUID) async throws -> Family
    func joinFamily(inviteCode: String, userId: UUID) async throws -> Family
    func getFamily(id: UUID) async throws -> Family?
    func getFamilyByUser(userId: UUID) async throws -> Family?
    func updateFamily(_ family: Family) async throws -> Family
    func leaveFamily(familyId: UUID, userId: UUID) async throws
    func generateInviteCode(familyId: UUID) async throws -> String
}

enum FamilyError: Error, Equatable {
    case familyNotFound
    case invalidInviteCode
    case alreadyMember
    case notMember
    case cannotLeaveAsOnlyAdmin
    case networkError
    case unknown(String)

    var localizedDescription: String {
        switch self {
        case .familyNotFound:
            return "가족을 찾을 수 없습니다."
        case .invalidInviteCode:
            return "유효하지 않은 초대 코드입니다."
        case .alreadyMember:
            return "이미 가족 구성원입니다."
        case .notMember:
            return "가족 구성원이 아닙니다."
        case .cannotLeaveAsOnlyAdmin:
            return "유일한 관리자는 가족을 떠날 수 없습니다."
        case .networkError:
            return "네트워크 연결을 확인해주세요."
        case .unknown(let message):
            return message
        }
    }
}
