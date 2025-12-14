//
//  LoginFeature.swift
//  FamTree
//
//  Created by 최용헌 on 12/12/25.
//

import Foundation
import ComposableArchitecture

enum SocialProviderType: String, CaseIterable, Equatable, Sendable {
  case kakao
  case naver
  case google
  
  var displayName: String {
    switch self {
    case .kakao:
      return "kakao"
    case .naver:
      return "naver"
    case .google:
      return "google"
    }
  }
}
  
@Reducer
struct LoginFeature {
  @ObservableState
  struct State: Equatable {
    
  }
  
  enum Action {
    case socialLoginTapped(SocialProviderType)
    case emailLoginTapped
    case emailSingupTapped
  }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
        
      case .socialLoginTapped(_):
        return .none
      case .emailLoginTapped:
        return .none
      case .emailSingupTapped:
        return .none
      }
    }
  }
  
}
