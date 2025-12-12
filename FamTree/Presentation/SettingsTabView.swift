//
//  SettingsTabView.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import SwiftUI
import ComposableArchitecture

struct SettingsTabView: View {
    let store: StoreOf<MainTabFeature>

    var body: some View {
        NavigationStack {
            List {
                Section("계정") {
                    HStack {
                        Text("이름")
                        Spacer()
                        Text(store.home.currentUser?.name ?? "-")
                            .foregroundColor(FTColor.textSecondary)
                    }
                    HStack {
                        Text("이메일")
                        Spacer()
                        Text(store.home.currentUser?.email ?? "-")
                            .foregroundColor(FTColor.textSecondary)
                    }
                }

                Section("앱 정보") {
                    HStack {
                        Text("버전")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(FTColor.textSecondary)
                    }
                }

                Section {
                    Button("로그아웃") {
                        store.send(.logout)
                    }
                    .foregroundColor(FTColor.error)
                }
            }
            .navigationTitle("설정")
        }
    }
}
