//
//  HomeFeature.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeFeature {
    @ObservableState
    struct State: Equatable {
        var selectedTab: Tab = .home
        var todayQuestion: Question?
        var familyTree: FamilyTree = FamilyTree()
        var family: Family?
        var currentUser: User?
        var isLoading = false

        enum Tab: Hashable, Sendable {
            case home
            case tree
            case family
            case settings
        }
    }

    enum Action: Sendable {
        case onAppear
        case selectTab(State.Tab)
        case loadDataResponse(Result<HomeData, Error>)
        case questionTapped
        case logout
    }

    struct HomeData: Equatable, Sendable {
        let question: Question?
        let tree: FamilyTree
        let family: Family?
        let user: User?
    }
  
  func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .onAppear:
        state.isLoading = true
        return .run { send in
            // TODO: Load actual data
            try await Task.sleep(nanoseconds: 500_000_000)
            let mockData = HomeData(
                question: Question(
                    id: UUID(),
                    content: "오늘 가장 감사했던 순간은 언제인가요?",
                    category: .gratitude,
                    order: 1
                ),
                tree: FamilyTree(
                    stage: .youngTree,
                    totalAnswers: 12,
                    consecutiveDays: 5
                ),
                family: Family(
                    id: UUID(),
                    name: "우리 가족",
                    members: [
                        User(id: UUID(), email: "dad@example.com", name: "아빠", profileImageURL: nil, role: .father, createdAt: .now),
                        User(id: UUID(), email: "mom@example.com", name: "엄마", profileImageURL: nil, role: .mother, createdAt: .now),
                        User(id: UUID(), email: "me@example.com", name: "나", profileImageURL: nil, role: .son, createdAt: .now)
                    ],
                    createdBy: UUID(),
                    createdAt: .now,
                    inviteCode: "ABCD1234",
                    familyTree: FamilyTree()
                ),
                user: User(id: UUID(), email: "me@example.com", name: "나", profileImageURL: nil, role: .son, createdAt: .now)
            )
            await send(.loadDataResponse(.success(mockData)))
        }

    case .selectTab(let tab):
        state.selectedTab = tab
        return .none

//      ㄱㄷ

    case .questionTapped:
        // TODO: Navigate to question detail
        return .none

    case .logout:
        return .none
    case .loadDataResponse(_):
      return .none
    }
  }


}
