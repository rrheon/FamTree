//
//  RootFeature.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RootFeature {
  @ObservableState
  struct State: Equatable {
    var appState: AppState = .loading
    var mainTab: MainTabFeature.State?
    var currentUser: User?
    
    enum AppState: Equatable {
      case loading
      case unauthenticated
      case authenticated
    }
  }
  
  enum Action: Sendable {
    case onAppear
    case checkAuthResponse(User?)
    case loadDataResponse(Result<RootData, Error>)
    case mainTab(MainTabFeature.Action)
    case logout
  }
  
  struct RootData: Equatable, Sendable {
    let user: User?
    let question: Question?
    let tree: FamilyTree
    let family: Family?
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .onAppear:
        state.appState = .loading
        return .run { send in
          // TODO: 실제 인증 체크 로직
          try await Task.sleep(nanoseconds: 500_000_000)
          
          // 임시 mock 데이터
          let mockUser = User(
            id: UUID(),
            email: "me@example.com",
            name: "나",
            profileImageURL: nil,
            role: .son,
            createdAt: .now
          )
          
          let mockData = RootData(
            user: mockUser,
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
                mockUser
              ],
              createdBy: UUID(),
              createdAt: .now,
              inviteCode: "ABCD1234",
              familyTree: FamilyTree()
            )
          )
          
          await send(.loadDataResponse(.success(mockData)))
        }
        
      case .checkAuthResponse(let user):
        if let user = user {
          state.currentUser = user
          state.appState = .authenticated
        } else {
          state.appState = .unauthenticated
        }
        return .none
        
      case .loadDataResponse(.success(let data)):
        state.currentUser = data.user
        
        // HomeFeature State 초기화
        var homeState = HomeFeature.State()
        homeState.todayQuestion = data.question
        homeState.familyTree = data.tree
        homeState.family = data.family
        homeState.currentUser = data.user
        homeState.isLoading = false
        
        // MainTabFeature State 초기화
        state.mainTab = MainTabFeature.State(home: homeState)
        state.appState = .authenticated
        return .none
        
      case .loadDataResponse(.failure):
        // TODO: 에러 처리
        state.appState = .unauthenticated
        return .none
        
      case .mainTab(.logout):
        state.appState = .unauthenticated
        state.mainTab = nil
        state.currentUser = nil
        return .none
        
      case .mainTab:
        return .none
        
      case .logout:
        state.appState = .unauthenticated
        state.mainTab = nil
        state.currentUser = nil
        return .none
      }
    }
    .ifLet(\.mainTab, action: \.mainTab) {
      MainTabFeature()
    }
  }
}
