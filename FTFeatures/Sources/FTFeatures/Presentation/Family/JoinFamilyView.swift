//
//  JoinFamilyView.swift
//  FamTree
//
//  Created by Claude on 2025-01-06.
//

import SwiftUI
import ComposableArchitecture
import Domain

struct JoinFamilyView: View {
    @Bindable var store: StoreOf<JoinFamilyFeature>
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                FTColor.surface
                    .ignoresSafeArea()

                ScrollView {
                    VStack(spacing: FTSpacing.xl) {
                        // Header
                        VStack(spacing: FTSpacing.sm) {
                            Image(systemName: "person.badge.plus")
                                .font(.system(size: 60))
                                .foregroundColor(FTColor.primary)

                            Text("가족 참여하기")
                                .font(FTFont.heading2())
                                .foregroundColor(FTColor.textPrimary)

                            Text("초대 코드를 입력하여\n가족에 참여해보세요")
                                .font(FTFont.body2())
                                .foregroundColor(FTColor.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, FTSpacing.xl)

                        // Form
                        VStack(spacing: FTSpacing.lg) {
                            // Invite Code Input
                            VStack(alignment: .leading, spacing: FTSpacing.xs) {
                                Text("초대 코드")
                                    .font(FTFont.body2())
                                    .foregroundColor(FTColor.textSecondary)

                                HStack(spacing: FTSpacing.sm) {
                                    TextField(
                                        "ABCD1234",
                                        text: Binding(
                                            get: { store.inviteCode },
                                            set: { store.send(.inviteCodeChanged($0)) }
                                        )
                                    )
                                    .font(FTFont.heading3())
                                    .textCase(.uppercase)
                                    .autocapitalization(.allCharacters)
                                    .disableAutocorrection(true)
                                    .padding(FTSpacing.md)
                                    .background(FTColor.background)
                                    .cornerRadius(FTRadius.medium)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: FTRadius.medium)
                                            .stroke(FTColor.border, lineWidth: 1)
                                    )
                                    .focused($isFocused)

                                    Button {
                                        isFocused = false
                                        store.send(.searchButtonTapped)
                                    } label: {
                                        if store.isSearching {
                                            ProgressView()
                                                .frame(width: 52, height: 52)
                                        } else {
                                            Image(systemName: "magnifyingglass")
                                                .font(.system(size: 20, weight: .semibold))
                                                .frame(width: 52, height: 52)
                                        }
                                    }
                                    .background(store.isValidCode ? FTColor.primary : FTColor.textHint)
                                    .foregroundColor(.white)
                                    .cornerRadius(FTRadius.medium)
                                    .disabled(!store.isValidCode || store.isSearching)
                                }
                            }

                            // Found Family Card
                            if let family = store.foundFamily {
                                FoundFamilyCard(family: family)
                                    .transition(.opacity.combined(with: .scale))
                            }

                            // Role Selection (only show when family is found)
                            if store.foundFamily != nil {
                                VStack(alignment: .leading, spacing: FTSpacing.xs) {
                                    Text("나의 역할")
                                        .font(FTFont.body2())
                                        .foregroundColor(FTColor.textSecondary)

                                    LazyVGrid(columns: [
                                        GridItem(.flexible()),
                                        GridItem(.flexible()),
                                        GridItem(.flexible())
                                    ], spacing: FTSpacing.sm) {
                                        ForEach(FamilyRole.allCases, id: \.self) { role in
                                            RoleSelectionButton(
                                                role: role,
                                                isSelected: store.selectedRole == role
                                            ) {
                                                store.send(.roleSelected(role))
                                            }
                                        }
                                    }
                                }
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                        .padding(.horizontal, FTSpacing.lg)
                        .animation(.easeInOut(duration: 0.3), value: store.foundFamily != nil)

                        // Error Message
                        if let errorMessage = store.errorMessage {
                            HStack {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundColor(FTColor.error)
                                Text(errorMessage)
                                    .font(FTFont.body2())
                                    .foregroundColor(FTColor.error)
                            }
                            .padding(FTSpacing.md)
                            .frame(maxWidth: .infinity)
                            .background(FTColor.error.opacity(0.1))
                            .cornerRadius(FTRadius.medium)
                            .padding(.horizontal, FTSpacing.lg)
                        }

                        Spacer()
                            .frame(height: FTSpacing.xl)

                        // Join Button
                        if store.foundFamily != nil {
                            FTButton(
                                "가족 참여하기",
                                style: .primary,
                                isLoading: store.isLoading
                            ) {
                                store.send(.joinButtonTapped)
                            }
                            .disabled(!store.canJoin)
                            .padding(.horizontal, FTSpacing.lg)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        store.send(.cancelTapped)
                    }
                    .foregroundColor(FTColor.textSecondary)
                }
            }
        }
    }
}

// MARK: - Found Family Card
struct FoundFamilyCard: View {
    let family: Family

    var body: some View {
        VStack(spacing: FTSpacing.md) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(FTColor.success)

                Text("가족을 찾았습니다!")
                    .font(FTFont.body1())
                    .fontWeight(.semibold)
                    .foregroundColor(FTColor.textPrimary)

                Spacer()
            }

            HStack {
                VStack(alignment: .leading, spacing: FTSpacing.xxs) {
                    Text(family.name)
                        .font(FTFont.heading3())
                        .foregroundColor(FTColor.textPrimary)

                    Text("구성원 \(family.memberIds.count)명")
                        .font(FTFont.caption())
                        .foregroundColor(FTColor.textSecondary)
                }

                Spacer()

                Image(systemName: "house.fill")
                    .font(.system(size: 40))
                    .foregroundColor(FTColor.primaryLight)
            }
        }
        .padding(FTSpacing.lg)
        .background(FTColor.success.opacity(0.1))
        .cornerRadius(FTRadius.large)
        .overlay(
            RoundedRectangle(cornerRadius: FTRadius.large)
                .stroke(FTColor.success.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Previews
#Preview("Join Family - Empty") {
    JoinFamilyView(
        store: Store(initialState: JoinFamilyFeature.State()) {
            JoinFamilyFeature()
        }
    )
}

#Preview("Join Family - Found") {
    JoinFamilyView(
        store: Store(initialState: JoinFamilyFeature.State(
            inviteCode: "TESTCODE",
            foundFamily: Family(
                id: UUID(),
                name: "행복한 가족",
                memberIds: [UUID(), UUID(), UUID()],
                createdBy: UUID(),
                createdAt: .now,
                inviteCode: "TESTCODE",
                treeProgressId: UUID()
            )
        )) {
            JoinFamilyFeature()
        }
    )
}

#Preview("Join Family - Error") {
    JoinFamilyView(
        store: Store(initialState: JoinFamilyFeature.State(
            inviteCode: "WRONG",
            errorMessage: "해당 초대 코드의 가족을 찾을 수 없습니다."
        )) {

            JoinFamilyFeature()
        }
    )
}
