//
//  FamilyRepositoryProtocol.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import Foundation

public protocol FamilyRepositoryInterface: Sendable {
    func create(_ family: Family) async throws -> Family
    func get(id: UUID) async throws -> Family
    func findByInviteCode(_ inviteCode: String) async throws -> Family?
    func getFamiliesByUserId(_ userId: UUID) async throws -> [Family]
    func update(_ family: Family) async throws -> Family
    func delete(id: UUID) async throws
    func addMember(_ member: Member) async throws
    func removeMember(userId: UUID, familyId: UUID) async throws
    func getMembers(familyId: UUID) async throws -> [Member]
    func isMember(userId: UUID, familyId: UUID) async throws -> Bool
}

public enum FamilyError: Error, Equatable, Sendable {
    case familyNotFound
    case invalidInviteCode
    case alreadyMember
    case notMember
    case cannotLeaveAsOnlyAdmin
    case networkError
    case unknown(String)

    public var localizedDescription: String {
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
