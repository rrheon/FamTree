//
//  RootView.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        Group {
            switch store.appState {
            case .loading:
                LoadingView()
                
            case .unauthenticated:
                LoginView()
                
            case .authenticated:
                if let mainTabStore = store.scope(state: \.mainTab, action: \.mainTab) {
                    MainTabView(store: mainTabStore)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

// MARK: - Loading View
struct LoadingView: View {
    var body: some View {
        VStack(spacing: FTSpacing.lg) {
            FTLogo(size: .large)
            ProgressView()
                .tint(FTColor.primary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(FTColor.surface)
    }
}



#Preview("Root - Loading") {
    RootView(
        store: Store(initialState: RootFeature.State(appState: .loading)) {
            RootFeature()
        }
    )
}

#Preview("Root - Unauthenticated") {
    RootView(
        store: Store(initialState: RootFeature.State(appState: .unauthenticated)) {
            RootFeature()
        }
    )
}

#Preview("Root - Authenticated") {
    RootView(
        store: Store(
            initialState: RootFeature.State(
                appState: .authenticated,
                mainTab: MainTabFeature.State(
                    home: HomeFeature.State(
                        todayQuestion: Question(
                            id: UUID(),
                            content: "오늘 가장 감사했던 순간은 언제인가요?",
                            category: .gratitude,
                            order: 1
                        ),
                        familyTree: FamilyTree(
                            stage: .youngTree,
                            totalAnswers: 12,
                            consecutiveDays: 5
                        )
                    )
                )
            )
        ) {
            RootFeature()
        }
    )
}
