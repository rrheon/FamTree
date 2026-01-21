//
//  CreateFamilyFeature.swift
//  FamTree
//
//  Created by Claude on 2025-01-06.
//

import Foundation
import ComposableArchitecture
import Domain

@Reducer
public struct CreateFamilyFeature {
    @ObservableState
    public struct State: Equatable {
        public var familyName: String = ""
        public var selectedRole: FamilyRole = .father
        public var isLoading: Bool = false
        public var errorMessage: String?

        public var isValid: Bool {
            !familyName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }

        public init(
            familyName: String = "",
            selectedRole: FamilyRole = .father,
            isLoading: Bool = false,
            errorMessage: String? = nil
        ) {
            self.familyName = familyName
            self.selectedRole = selectedRole
            self.isLoading = isLoading
            self.errorMessage = errorMessage
        }
    }

    public enum Action: Sendable, Equatable {
        // MARK: - View Actions
        case familyNameChanged(String)
        case roleSelected(FamilyRole)
        case createButtonTapped
        case dismissErrorTapped
        case cancelTapped

        // MARK: - Internal Actions
        case createFamilyResponse(Result<Family, FamilyCreationError>)

        // MARK: - Delegate Actions
        case delegate(Delegate)

        public enum Delegate: Sendable, Equatable {
            case familyCreated(Family)
            case cancelled
        }
    }

    public enum FamilyCreationError: Error, Equatable, Sendable {
        case invalidName
        case networkError
        case unknown(String)

        var localizedDescription: String {
            switch self {
            case .invalidName:
                return "가족 이름을 입력해주세요."
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
            case .familyNameChanged(let name):
                state.familyName = name
                state.errorMessage = nil
                return .none

            case .roleSelected(let role):
                state.selectedRole = role
                return .none

            case .createButtonTapped:
                guard state.isValid else {
                    state.errorMessage = "가족 이름을 입력해주세요."
                    return .none
                }

                state.isLoading = true
                state.errorMessage = nil

                let familyName = state.familyName.trimmingCharacters(in: .whitespacesAndNewlines)
                let role = state.selectedRole

                return .run { send in
                    // TODO: 실제 API 호출로 교체
                    try await Task.sleep(nanoseconds: 1_000_000_000)

                    // Mock 응답
                    let newFamily = Family(
                        id: UUID(),
                        name: familyName,
                        memberIds: [UUID()],
                        createdBy: UUID(),
                        createdAt: .now,
                        inviteCode: generateInviteCode(),
                        treeProgressId: UUID()
                    )

                    await send(.createFamilyResponse(.success(newFamily)))
                }

            case .dismissErrorTapped:
                state.errorMessage = nil
                return .none

            case .cancelTapped:
                return .send(.delegate(.cancelled))

            // MARK: - Internal Actions
            case .createFamilyResponse(.success(let family)):
                state.isLoading = false
                return .send(.delegate(.familyCreated(family)))

            case .createFamilyResponse(.failure(let error)):
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

// MARK: - Helper Functions
private func generateInviteCode() -> String {
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<8).map { _ in characters.randomElement()! })
}
