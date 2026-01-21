//
//  AuthRepositoryProtocol.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import Foundation

public protocol AuthRepositoryInterface: Sendable {
    func login(email: String, password: String) async throws -> User
    func signup(name: String, email: String, password: String, role: FamilyRole) async throws -> User
    func logout() async throws
    func getCurrentUser() async throws -> User?
}

public enum AuthError: Error, Equatable, Sendable {
    case invalidCredentials
    case emailAlreadyExists
    case weakPassword
    case networkError
    case userNotFound
    case unknown(String)

    public var localizedDescription: String {
        switch self {
        case .invalidCredentials:
            return "이메일 또는 비밀번호가 올바르지 않습니다."
        case .emailAlreadyExists:
            return "이미 사용 중인 이메일입니다."
        case .weakPassword:
            return "비밀번호는 최소 6자 이상이어야 합니다."
        case .networkError:
            return "네트워크 연결을 확인해주세요."
        case .userNotFound:
            return "사용자를 찾을 수 없습니다."
        case .unknown(let message):
            return message
        }
    }
}
