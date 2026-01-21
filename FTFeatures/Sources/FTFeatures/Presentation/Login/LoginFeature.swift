//
//  LoginFeature.swift
//  FamTree
//
//  Created by 최용헌 on 12/12/25.
//

import Foundation
import ComposableArchitecture

public enum SocialProviderType: String, CaseIterable, Equatable, Sendable {
  case kakao
  case naver
  case google

  public var displayName: String {
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
public struct LoginFeature {
  @ObservableState
  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Sendable {
    case socialLoginTapped(SocialProviderType)
    case emailLoginTapped
    case emailSingupTapped
  }

  public init() {}

  public var body: some Reducer<State, Action> {
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
