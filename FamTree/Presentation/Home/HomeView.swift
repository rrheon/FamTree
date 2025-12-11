//
//  HomeView.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import SwiftUI
import ComposableArchitecture

struct HomeView: View {
    @Bindable var store: StoreOf<HomeFeature>

    var body: some View {
        TabView(selection: $store.selectedTab.sending(\.selectTab)) {
            HomeTabView(store: store)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
                .tag(HomeFeature.State.Tab.home)

            TreeTabView(store: store)
                .tabItem {
                    Image(systemName: "leaf.fill")
                    Text("나무")
                }
                .tag(HomeFeature.State.Tab.tree)

            FamilyTabView(store: store)
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("가족")
                }
                .tag(HomeFeature.State.Tab.family)

            SettingsTabView(store: store)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("설정")
                }
                .tag(HomeFeature.State.Tab.settings)
        }
        .tint(FTColor.primary)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

// MARK: - Home Tab
struct HomeTabView: View {
    let store: StoreOf<HomeFeature>

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: FTSpacing.lg) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: FTSpacing.xxs) {
                            Text("안녕하세요!")
                                .font(FTFont.body1())
                                .foregroundColor(FTColor.textSecondary)
                            Text(store.currentUser?.name ?? "사용자")
                                .font(FTFont.heading2())
                                .foregroundColor(FTColor.textPrimary)
                        }
                        Spacer()
                        FTLogo(size: .small)
                    }
                    .padding(.horizontal, FTSpacing.lg)
                    .padding(.top, FTSpacing.md)

                    // Today's Question Card
                    if let question = store.todayQuestion {
                        TodayQuestionCard(question: question) {
                            store.send(.questionTapped)
                        }
                        .padding(.horizontal, FTSpacing.lg)
                    }

                    // Tree Progress Card
                    TreeProgressCard(tree: store.familyTree)
                        .padding(.horizontal, FTSpacing.lg)

                    // Family Activity
                    if let family = store.family {
                        FamilyActivityCard(family: family)
                            .padding(.horizontal, FTSpacing.lg)
                    }

                    Spacer()
                        .frame(height: FTSpacing.xl)
                }
            }
            .background(FTColor.surface)
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Today Question Card
struct TodayQuestionCard: View {
    let question: Question
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: FTSpacing.md) {
                HStack {
                  Text("\(question.category) 오늘의 질문")
                        .font(FTFont.body2())
                        .foregroundColor(FTColor.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(FTColor.textHint)
                }

                Text(question.content)
                    .font(FTFont.heading3())
                    .foregroundColor(FTColor.textPrimary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(3)
            }
            .padding(FTSpacing.lg)
            .background(FTColor.background)
            .cornerRadius(FTRadius.large)
            .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Tree Progress Card
struct TreeProgressCard: View {
    let tree: FamilyTree

    var body: some View {
        VStack(spacing: FTSpacing.md) {
            HStack {
                Text("우리 가족 나무")
                    .font(FTFont.body1())
                    .fontWeight(.semibold)
                    .foregroundColor(FTColor.textPrimary)
                Spacer()
              Text("Lv.\(tree.consecutiveDays)")
                    .font(FTFont.body2())
                    .foregroundColor(FTColor.primary)
            }

            HStack(spacing: FTSpacing.lg) {
                // Tree Icon
                ZStack {
                    Circle()
                        .fill(FTColor.primaryLight.opacity(0.3))
                        .frame(width: 80, height: 80)

                    Image(systemName: treeIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(FTColor.primary)
                }

                VStack(alignment: .leading, spacing: FTSpacing.xs) {
                  Text("\(tree.stage.rawValue)")
                        .font(FTFont.heading3())
                        .foregroundColor(FTColor.textPrimary)

                    // Progress Bar
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(FTColor.surface)
                                .frame(height: 8)

                            RoundedRectangle(cornerRadius: 4)
                                .fill(FTColor.primary)
                                .frame(width: geometry.size.width * CGFloat(tree.stage.rawValue), height: 8)
                        }
                    }
                    .frame(height: 8)
//
//                  Text("\(tree.)/\(tree.experienceForNextLevel) XP")
//                        .font(FTFont.caption())
//                        .foregroundColor(FTColor.textSecondary)
                }
            }

            HStack(spacing: FTSpacing.lg) {
                StatItem(value: "\(tree.totalAnswers)", label: "총 답변")
                StatItem(value: "\(tree.consecutiveDays)일", label: "연속 답변")
//                StatItem(value: "\(tree.badges.count)", label: "배지")
            }
        }
        .padding(FTSpacing.lg)
        .background(FTColor.background)
        .cornerRadius(FTRadius.large)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
    }

    private var treeIcon: String {
        switch tree.stage {
        case .seed: return "leaf.circle"
        case .sprout: return "leaf"
        case .sapling: return "leaf.fill"
        case .youngTree: return "tree"
        case .matureTree: return "tree.fill"
        case .flowering: return "tree.fill"
        }
    }
}

struct StatItem: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: FTSpacing.xxs) {
            Text(value)
                .font(FTFont.heading3())
                .foregroundColor(FTColor.primary)
            Text(label)
                .font(FTFont.caption())
                .foregroundColor(FTColor.textSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Family Activity Card
struct FamilyActivityCard: View {
    let family: Family

    var body: some View {
        VStack(alignment: .leading, spacing: FTSpacing.md) {
            Text("가족 구성원")
                .font(FTFont.body1())
                .fontWeight(.semibold)
                .foregroundColor(FTColor.textPrimary)

            HStack(spacing: FTSpacing.sm) {
                ForEach(family.members) { member in
                    VStack(spacing: FTSpacing.xxs) {
                        Circle()
                            .fill(FTColor.primaryLight)
                            .frame(width: 48, height: 48)
                            .overlay(
                                Text(String(member.name.prefix(1)))
                                    .font(FTFont.body1())
                                    .foregroundColor(FTColor.primaryDark)
                            )

                        Text(member.name)
                            .font(FTFont.caption())
                            .foregroundColor(FTColor.textSecondary)
                    }
                }
                Spacer()
            }
        }
        .padding(FTSpacing.lg)
        .background(FTColor.background)
        .cornerRadius(FTRadius.large)
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 4)
    }
}

// MARK: - Placeholder Tabs
struct TreeTabView: View {
    let store: StoreOf<HomeFeature>

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

struct FamilyTabView: View {
    let store: StoreOf<HomeFeature>

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

struct SettingsTabView: View {
    let store: StoreOf<HomeFeature>

    var body: some View {
        NavigationStack {
            List {
                Section("계정") {
                    HStack {
                        Text("이름")
                        Spacer()
                        Text(store.currentUser?.name ?? "-")
                            .foregroundColor(FTColor.textSecondary)
                    }
                    HStack {
                        Text("이메일")
                        Spacer()
                        Text(store.currentUser?.email ?? "-")
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

#Preview {
    HomeView(
        store: Store(initialState: HomeFeature.State()) {
            HomeFeature()
        }
    )
}
