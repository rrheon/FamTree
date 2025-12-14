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
        var todayQuestion: Question?
        var familyTree: FamilyTree = FamilyTree()
        var family: Family?
        var currentUser: User?
        var isLoading = false
    }

    enum Action: Sendable {
        case questionTapped
        case refreshData
    }
  
  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .questionTapped:
          // TODO: Navigate to question detail
          return .none
          
      case .refreshData:
          // TODO: Refresh home data
          return .none
      }
    }
  }
}

