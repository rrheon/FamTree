//
//  DesignSystem.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import SwiftUI

// MARK: - Colors
enum FTColor {
    static let primary = Color(hex: "7CB342")
    static let primaryDark = Color(hex: "558B2F")
    static let primaryLight = Color(hex: "AED581")

    static let kakao = Color(hex: "FEE500")
    static let kakaoText = Color(hex: "000000")
    static let naver = Color(hex: "03C75A")
    static let naverText = Color(hex: "FFFFFF")

    static let background = Color(hex: "FFFFFF")
    static let surface = Color(hex: "F5F5F5")
    static let textPrimary = Color(hex: "212121")
    static let textSecondary = Color(hex: "757575")
    static let textHint = Color(hex: "9E9E9E")
    static let divider = Color(hex: "E0E0E0")
    static let error = Color(hex: "F44336")
    static let success = Color(hex: "4CAF50")
}

// MARK: - Typography
enum FTFont {
    static func heading1() -> Font {
        .system(size: 28, weight: .bold)
    }

    static func heading2() -> Font {
        .system(size: 24, weight: .bold)
    }

    static func heading3() -> Font {
        .system(size: 20, weight: .semibold)
    }

    static func body1() -> Font {
        .system(size: 16, weight: .regular)
    }

    static func body2() -> Font {
        .system(size: 14, weight: .regular)
    }

    static func caption() -> Font {
        .system(size: 12, weight: .regular)
    }

    static func button() -> Font {
        .system(size: 16, weight: .semibold)
    }
}

// MARK: - Spacing
enum FTSpacing {
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}

// MARK: - Corner Radius
enum FTRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 12
    static let large: CGFloat = 16
    static let full: CGFloat = 9999
}

// MARK: - Color Extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
