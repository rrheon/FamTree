//
//  CreateFamilyView.swift
//  FamTree
//
//  Created by Claude on 2025-01-06.
//

import SwiftUI
import ComposableArchitecture
import Domain

struct CreateFamilyView: View {
    @Bindable var store: StoreOf<CreateFamilyFeature>
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
                            Image(systemName: "house.fill")
                                .font(.system(size: 60))
                                .foregroundColor(FTColor.primary)

                            Text("새 가족 만들기")
                                .font(FTFont.heading2())
                                .foregroundColor(FTColor.textPrimary)

                            Text("가족 이름을 정하고\n나의 역할을 선택해주세요")
                                .font(FTFont.body2())
                                .foregroundColor(FTColor.textSecondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, FTSpacing.xl)

                        // Form
                        VStack(spacing: FTSpacing.lg) {
                            // Family Name Input
                            VStack(alignment: .leading, spacing: FTSpacing.xs) {
                                Text("가족 이름")
                                    .font(FTFont.body2())
                                    .foregroundColor(FTColor.textSecondary)

                                TextField(
                                    "예: 우리 가족, 행복한 우리집",
                                    text: Binding(
                                        get: { store.familyName },
                                        set: { store.send(.familyNameChanged($0)) }
                                    )
                                )
                                .font(FTFont.body1())
                                .padding(FTSpacing.md)
                                .background(FTColor.background)
                                .cornerRadius(FTRadius.medium)
                                .overlay(
                                    RoundedRectangle(cornerRadius: FTRadius.medium)
                                        .stroke(FTColor.border, lineWidth: 1)
                                )
                                .focused($isFocused)
                            }

                            // Role Selection
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
                        }
                        .padding(.horizontal, FTSpacing.lg)

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

                        // Create Button
                        FTButton(
                            "가족 만들기",
                            style: .primary,
                            isLoading: store.isLoading
                        ) {
                            isFocused = false
                            store.send(.createButtonTapped)
                        }
                        .disabled(!store.isValid || store.isLoading)
                        .opacity(store.isValid ? 1 : 0.6)
                        .padding(.horizontal, FTSpacing.lg)
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

// MARK: - Role Selection Button
struct RoleSelectionButton: View {
    let role: FamilyRole
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: FTSpacing.xs) {
                Image(systemName: iconName)
                    .font(.system(size: 24))

                Text(role.rawValue)
                    .font(FTFont.body2())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, FTSpacing.md)
            .background(isSelected ? FTColor.primaryLight : FTColor.background)
            .foregroundColor(isSelected ? FTColor.primaryDark : FTColor.textSecondary)
            .cornerRadius(FTRadius.medium)
            .overlay(
                RoundedRectangle(cornerRadius: FTRadius.medium)
                    .stroke(isSelected ? FTColor.primary : FTColor.border, lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var iconName: String {
        switch role {
        case .father: return "figure.stand"
        case .mother: return "figure.stand.dress"
        case .son: return "figure.child"
        case .daughter: return "figure.child.and.lock.fill"
        case .other: return "person.fill"
        }
    }
}

// MARK: - FamilyRole Extension for allCases
extension FamilyRole: CaseIterable {
    public static var allCases: [FamilyRole] {
        [.father, .mother, .son, .daughter, .other]
    }
}

// MARK: - Previews
#Preview("Create Family") {
    CreateFamilyView(
        store: Store(initialState: CreateFamilyFeature.State()) {
            CreateFamilyFeature()
        }
    )
}

#Preview("Create Family - With Error") {
    CreateFamilyView(
        store: Store(initialState: CreateFamilyFeature.State(
            familyName: "",
            errorMessage: "가족 이름을 입력해주세요."
        )) {
            CreateFamilyFeature()
        }
    )
}

#Preview("Create Family - Loading") {
    CreateFamilyView(
        store: Store(initialState: CreateFamilyFeature.State(
            familyName: "우리 가족",
            isLoading: true
        )) {
            CreateFamilyFeature()
        }
    )
}
