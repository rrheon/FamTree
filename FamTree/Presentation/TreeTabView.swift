//
//  TreeTabView.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Placeholder Tabs
struct TreeTabView: View {
    let store: StoreOf<MainTabFeature>

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                FTLogo(size: .large)
                Text("나무 성장 화면")
                    .font(FTFont.heading2())
                    .foregroundColor(FTColor.textSecondary)
                    .padding(.top, FTSpacing.lg)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(FTColor.surface)
            .navigationTitle("나무")
        }
    }
}
