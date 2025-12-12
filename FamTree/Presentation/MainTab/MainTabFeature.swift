//
//  MainTabFeature.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainTabFeature {
    @ObservableState
    struct State: Equatable {
        var selectedTab: Tab = .home
        var home: HomeFeature.State
        // 나중에 추가할 다른 탭들
        // var tree: TreeFeature.State
        // var family: FamilyFeature.State
        // var settings: SettingsFeature.State
        
        enum Tab: Hashable, Sendable {
            case home
            case tree
            case family
            case settings
        }
    }
    
    enum Action: Sendable {
        case selectTab(State.Tab)
        case home(HomeFeature.Action)
        case logout
        // 나중에 추가할 다른 탭들
        // case tree(TreeFeature.Action)
        // case family(FamilyFeature.Action)
        // case settings(SettingsFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .selectTab(let tab):
                state.selectedTab = tab
                return .none
                
            case .home:
                return .none
                
            case .logout:
                // 로그아웃은 상위로 전달 (RootFeature에서 처리)
                return .none
            }
        }
    }
}
