//
//  SettingsFeature.swift
//  FamTree
//
//  Created by Claude on 2025-01-06.
//

import Foundation
import ComposableArchitecture
import Domain

@Reducer
public struct SettingsFeature {
    @ObservableState
    public struct State: Equatable {
        public var currentUser: User?
        public var appVersion: String
        public var notificationsEnabled: Bool
        public var isLoading: Bool
        public var showLogoutConfirmation: Bool
        public var errorMessage: String?

        public init(
            currentUser: User? = nil,
            appVersion: String = "1.0.0",
            notificationsEnabled: Bool = true,
            isLoading: Bool = false,
            showLogoutConfirmation: Bool = false,
            errorMessage: String? = nil
        ) {
            self.currentUser = currentUser
            self.appVersion = appVersion
            self.notificationsEnabled = notificationsEnabled
            self.isLoading = isLoading
            self.showLogoutConfirmation = showLogoutConfirmation
            self.errorMessage = errorMessage
        }
    }

    public enum Action: Sendable, Equatable {
        // MARK: - View Actions
        case onAppear
        case notificationsToggled(Bool)
        case logoutTapped
        case logoutConfirmed
        case logoutCancelled
        case dismissErrorTapped
        case termsOfServiceTapped
        case privacyPolicyTapped
        case contactUsTapped

        // MARK: - Internal Actions
        case loadUserResponse(Result<User, SettingsError>)

        // MARK: - Delegate Actions
        case delegate(Delegate)

        public enum Delegate: Sendable, Equatable {
            case logout
            case openURL(URL)
        }
    }

    public enum SettingsError: Error, Equatable, Sendable {
        case networkError
        case unknown(String)

        var localizedDescription: String {
            switch self {
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
            case .onAppear:
                // User data is typically passed from parent, but we can load if needed
                return .none

            case .notificationsToggled(let enabled):
                state.notificationsEnabled = enabled
                // TODO: 실제 알림 설정 저장
                return .none

            case .logoutTapped:
                state.showLogoutConfirmation = true
                return .none

            case .logoutConfirmed:
                state.showLogoutConfirmation = false
                return .send(.delegate(.logout))

            case .logoutCancelled:
                state.showLogoutConfirmation = false
                return .none

            case .dismissErrorTapped:
                state.errorMessage = nil
                return .none

            case .termsOfServiceTapped:
                if let url = URL(string: "https://example.com/terms") {
                    return .send(.delegate(.openURL(url)))
                }
                return .none

            case .privacyPolicyTapped:
                if let url = URL(string: "https://example.com/privacy") {
                    return .send(.delegate(.openURL(url)))
                }
                return .none

            case .contactUsTapped:
                if let url = URL(string: "mailto:support@famtree.app") {
                    return .send(.delegate(.openURL(url)))
                }
                return .none

            case .loadUserResponse(.success(let user)):
                state.currentUser = user
                return .none

            case .loadUserResponse(.failure(let error)):
                state.errorMessage = error.localizedDescription
                return .none

            case .delegate:
                return .none
            }
        }
    }
}
