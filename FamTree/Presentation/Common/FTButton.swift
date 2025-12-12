//
//  FTButton.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import SwiftUI

struct FTButton: View {
    enum Style {
        case primary
        case secondary
        case kakao
        case naver
        case google
    }

    let title: String
    let style: Style
    let isLoading: Bool
    let action: () -> Void

    init(
        _ title: String,
        style: Style = .primary,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.style = style
        self.isLoading = isLoading
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: FTSpacing.xs) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: textColor))
                        .scaleEffect(0.8)
                } else {
                    if let icon = iconName {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    Text(title)
                        .font(FTFont.button())
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(FTRadius.medium)
            .overlay(
                RoundedRectangle(cornerRadius: FTRadius.medium)
                    .stroke(borderColor, lineWidth: hasBorder ? 1 : 0)
            )
        }
        .disabled(isLoading)
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: return FTColor.primary
        case .secondary: return FTColor.surface
        case .kakao: return FTColor.kakao
        case .naver: return FTColor.naver
        case .google: return FTColor.background
        }
    }

    private var textColor: Color {
        switch style {
        case .primary: return .white
        case .secondary: return FTColor.textPrimary
        case .kakao: return FTColor.kakaoText
        case .naver: return FTColor.naverText
        case .google: return FTColor.textPrimary
        }
    }

    private var borderColor: Color {
        switch style {
        case .google: return FTColor.divider
        default: return .clear
        }
    }

    private var hasBorder: Bool {
        style == .google
    }

    private var iconName: String? {
        switch style {
        case .kakao: return "kakao_icon"
        case .naver: return "naver_icon"
        case .google: return "google_icon"
        default: return nil
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        FTButton("회원가입", style: .primary) {}
        FTButton("카카오로 시작하기", style: .kakao) {}
        FTButton("네이버로 시작하기", style: .naver) {}
        FTButton("Google로 시작하기", style: .google) {}
    }
    .padding()
}
