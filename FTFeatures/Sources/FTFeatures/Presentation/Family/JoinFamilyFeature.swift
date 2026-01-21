//
//  JoinFamilyFeature.swift
//  FamTree
//
//  Created by Claude on 2025-01-06.
//

import Foundation
import ComposableArchitecture
import Domain

@Reducer
public struct JoinFamilyFeature {
    @ObservableState
    public struct State: Equatable {
        public var inviteCode: String = ""
        public var selectedRole: FamilyRole = .son
        public var isLoading: Bool = false
        public var isSearching: Bool = false
        public var foundFamily: Family?
        public var errorMessage: String?

        public var isValidCode: Bool {
            inviteCode.trimmingCharacters(in: .whitespacesAndNewlines).count >= 6
        }

        public var canJoin: Bool {
            foundFamily != nil && !isLoading
        }

        public init(
            inviteCode: String = "",
            selectedRole: FamilyRole = .son,
            isLoading: Bool = false,
            isSearching: Bool = false,
            foundFamily: Family? = nil,
            errorMessage: String? = nil
        ) {
            self.inviteCode = inviteCode
            self.selectedRole = selectedRole
            self.isLoading = isLoading
            self.isSearching = isSearching
            self.foundFamily = foundFamily
            self.errorMessage = errorMessage
        }
    }

    public enum Action: Sendable, Equatable {
        // MARK: - View Actions
        case inviteCodeChanged(String)
        case roleSelected(FamilyRole)
        case searchButtonTapped
        case joinButtonTapped
        case dismissErrorTapped
        case cancelTapped
        case clearFoundFamily

        // MARK: - Internal Actions
        case searchFamilyResponse(Result<Family?, JoinFamilyError>)
        case joinFamilyResponse(Result<Family, JoinFamilyError>)

        // MARK: - Delegate Actions
        case delegate(Delegate)

        public enum Delegate: Sendable, Equatable {
            case familyJoined(Family)
            case cancelled
        }
    }

    public enum JoinFamilyError: Error, Equatable, Sendable {
        case invalidCode
        case familyNotFound
        case alreadyMember
        case networkError
        case unknown(String)

        var localizedDescription: String {
            switch self {
            case .invalidCode:
                return "유효하지 않은 초대 코드입니다."
            case .familyNotFound:
                return "해당 초대 코드의 가족을 찾을 수 없습니다."
            case .alreadyMember:
                return "이미 가입된 가족입니다."
            case .networkError:
                return "네트워크 연결을 확인해주세요."
            case .unknown(let message):
                return message
            }
        }
    }

    public init() {}

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            // MARK: - View Actions
            case .inviteCodeChanged(let code):
                state.inviteCode = code.uppercased()
                state.errorMessage = nil
                // 코드가 변경되면 찾은 가족 초기화
                if state.foundFamily != nil {
                    state.foundFamily = nil
                }
                return .none

            case .roleSelected(let role):
                state.selectedRole = role
                return .none

            case .searchButtonTapped:
                guard state.isValidCode else {
                    state.errorMessage = "초대 코드를 입력해주세요. (6자 이상)"
                    return .none
                }

                state.isSearching = true
                state.errorMessage = nil
                state.foundFamily = nil

                let code = state.inviteCode.trimmingCharacters(in: .whitespacesAndNewlines)

                return .run { send in
                    // TODO: 실제 API 호출로 교체
                    try await Task.sleep(nanoseconds: 1_000_000_000)

                    // Mock 응답 - 코드가 "TESTCODE" 또는 8자면 성공
                    if code == "TESTCODE" || code.count == 8 {
                        let family = Family(
                            id: UUID(),
                            name: "행복한 가족",
                            memberIds: [UUID(), UUID()],
                            createdBy: UUID(),
                            createdAt: .now,
                            inviteCode: code,
                            treeProgressId: UUID()
                        )
                        await send(.searchFamilyResponse(.success(family)))
                    } else {
                        await send(.searchFamilyResponse(.failure(.familyNotFound)))
                    }
                }

            case .joinButtonTapped:
                guard let family = state.foundFamily else { return .none }

                state.isLoading = true
                state.errorMessage = nil

                let role = state.selectedRole

                return .run { send in
                    // TODO: 실제 API 호출로 교체
                    try await Task.sleep(nanoseconds: 1_000_000_000)

                    // Mock 성공 응답
                    await send(.joinFamilyResponse(.success(family)))
                }

            case .dismissErrorTapped:
                state.errorMessage = nil
                return .none

            case .cancelTapped:
                return .send(.delegate(.cancelled))

            case .clearFoundFamily:
                state.foundFamily = nil
                return .none

            // MARK: - Internal Actions
            case .searchFamilyResponse(.success(let family)):
                state.isSearching = false
                state.foundFamily = family
                return .none

            case .searchFamilyResponse(.failure(let error)):
                state.isSearching = false
                state.errorMessage = error.localizedDescription
                return .none

            case .joinFamilyResponse(.success(let family)):
                state.isLoading = false
                return .send(.delegate(.familyJoined(family)))

            case .joinFamilyResponse(.failure(let error)):
                state.isLoading = false
                state.errorMessage = error.localizedDescription
                return .none

            // MARK: - Delegate Actions
            case .delegate:
                return .none
            }
        }
    }
}
