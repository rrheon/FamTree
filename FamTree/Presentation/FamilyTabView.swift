//
//  FamilyTabView.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//
import SwiftUI
import ComposableArchitecture

struct FamilyTabView: View {
    let store: StoreOf<MainTabFeature>

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image(systemName: "person.3.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(FTColor.primary)
                Text("가족 화면")
                    .font(FTFont.heading2())
                    .foregroundColor(FTColor.textSecondary)
                    .padding(.top, FTSpacing.lg)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(FTColor.surface)
            .navigationTitle("가족")
        }
    }
}
