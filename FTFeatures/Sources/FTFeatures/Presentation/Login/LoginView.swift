//
//  LoginView.swift
//  FamTree
//
//  Created by 최용헌 on 12/12/25.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Login View
struct LoginView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                colors: [FTColor.primaryLight.opacity(0.3), FTColor.surface, FTColor.background],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: FTSpacing.xl) {
                Spacer()

                // Logo Section
                VStack(spacing: FTSpacing.lg) {
                    // Animated Logo
                    ZStack {
                        Circle()
                            .fill(FTColor.primaryLight)
                            .frame(width: 120, height: 120)
                            .scaleEffect(isAnimating ? 1.05 : 1.0)

                        FTLogo(size: .large, type: .FamTreeImg)
                    }
                    .animation(
                        .easeInOut(duration: 2.0).repeatForever(autoreverses: true),
                        value: isAnimating
                    )

                    // Title
                    VStack(spacing: FTSpacing.xs) {
                        Text("FamTree")
                            .font(FTFont.heading1())
                            .foregroundColor(FTColor.textPrimary)

                        Text("가족과 함께 추억을 쌓아보세요")
                            .font(FTFont.body1())
                            .foregroundColor(FTColor.textSecondary)
                    }
                }

                Spacer()

                // Social Login Section
                VStack(spacing: FTSpacing.lg) {
                    // Divider with text
                    HStack(spacing: FTSpacing.md) {
                        Rectangle()
                            .fill(FTColor.divider)
                            .frame(height: 1)
                        Text("간편 로그인")
                            .font(FTFont.caption())
                            .foregroundColor(FTColor.textHint)
                        Rectangle()
                            .fill(FTColor.divider)
                            .frame(height: 1)
                    }

                    // Social Login Buttons - Horizontal
                    HStack(spacing: FTSpacing.md) {
                        SocialLoginCircleButton(
                            icon: "kakao_icon",
                            backgroundColor: FTColor.kakao,
                            label: "카카오"
                        ) {
                            // Kakao login
                        }

                        SocialLoginCircleButton(
                            icon: "naver_icon",
                            backgroundColor: FTColor.naver,
                            label: "네이버"
                        ) {
                            // Naver login
                        }

                        SocialLoginCircleButton(
                            systemIcon: "apple.logo",
                            backgroundColor: FTColor.apple,
                            iconColor: FTColor.appleText,
                            label: "Apple"
                        ) {
                            // Apple login
                        }
                    }
                }

                // Primary Actions
                VStack(spacing: FTSpacing.md) {
                    FTButton("이메일로 로그인", style: .primary) {
                        // Email login
                    }

                    FTButton("회원가입", style: .secondary) {
                        // Sign up
                    }
                }
                .padding(.horizontal, FTSpacing.lg)

                // Guest mode
                Button {
                    // Guest mode
                } label: {
                    Text("둘러보기")
                        .font(FTFont.body2())
                        .foregroundColor(FTColor.textSecondary)
                        .underline()
                }
                .padding(.top, FTSpacing.sm)

                Spacer()
                    .frame(height: FTSpacing.lg)
            }
            .padding(.horizontal, FTSpacing.lg)
        }
        .onAppear {
            isAnimating = true
        }
    }
}

// MARK: - Social Login Circle Button
private struct SocialLoginCircleButton: View {
    var icon: String? = nil
    var systemIcon: String? = nil
    let backgroundColor: Color
    var iconColor: Color = .white
    let label: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: FTSpacing.xs) {
            Button(action: action) {
                ZStack {
                    Circle()
                        .fill(backgroundColor)
                        .frame(width: 56, height: 56)
                        .shadow(color: backgroundColor.opacity(0.3), radius: 8, x: 0, y: 4)

                    if let icon = icon {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    } else if let systemIcon = systemIcon {
                        Image(systemName: systemIcon)
                            .font(.system(size: 24))
                            .foregroundColor(iconColor)
                    }
                }
            }
            .buttonStyle(ScaleButtonStyle())

            Text(label)
                .font(FTFont.caption())
                .foregroundColor(FTColor.textSecondary)
        }
    }
}

// MARK: - Onboarding Page View (Optional - for future)
struct OnboardingPageView: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: FTSpacing.lg) {
            ZStack {
                Circle()
                    .fill(FTColor.primaryLight)
                    .frame(width: 140, height: 140)

                Image(systemName: icon)
                    .font(.system(size: 60))
                    .foregroundColor(FTColor.primary)
            }

            VStack(spacing: FTSpacing.sm) {
                Text(title)
                    .font(FTFont.heading2())
                    .foregroundColor(FTColor.textPrimary)

                Text(description)
                    .font(FTFont.body1())
                    .foregroundColor(FTColor.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }
        }
        .padding(FTSpacing.xl)
    }
}

#Preview("Login") {
    LoginView()
}

#Preview("Onboarding Page") {
    OnboardingPageView(
        icon: "leaf.fill",
        title: "가족 나무를 키워요",
        description: "매일 질문에 답하면\n가족 나무가 성장해요"
    )
}
