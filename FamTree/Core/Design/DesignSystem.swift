//
//  DesignSystem.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import SwiftUI

// MARK: - Colors

// MARK: - Colors
enum FTColor {
    // Primary Colors
    static let primary = Color(light: "4CAF50", dark: "66D267")
    static let primaryLight = Color(light: "81C784", dark: "81C784")
    static let primaryDark = Color(light: "388E3C", dark: "4CAF50")
    
    // Social Login Colors
    static let kakao = Color(hex: "FEE500")
    static let kakaoText = Color(hex: "000000")
    static let naver = Color(hex: "03C75A")
    static let naverText = Color(hex: "FFFFFF")
    
    // Background Colors
    static let background = Color(light: "FFFFFF", dark: "121212")
    static let surface = Color(light: "F7F8FA", dark: "1E1E1E")
    
    // Border & Divider
    static let border = Color(light: "E0E0E0", dark: "2E2E2E")
    static let divider = Color(light: "E0E0E0", dark: "2E2E2E")
    
    // Text Colors
    static let textPrimary = Color(light: "212121", dark: "FFFFFF")
    static let textSecondary = Color(light: "616161", dark: "BDBDBD")
    static let textHint = Color(light: "9E9E9E", dark: "757575")
    
    // Status Colors
    static let error = Color(light: "F44336", dark: "EF5350")
    static let warning = Color(light: "FFC107", dark: "FFCA28")
    static let success = Color(light: "4CAF50", dark: "66BB6A")
    static let info = Color(light: "2196F3", dark: "42A5F5")

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
    
  
  /// Light Mode와 Dark Mode를 모두 지원하는 Color 초기화
  init(light: String, dark: String) {
      self.init(UIColor { traitCollection in
          traitCollection.userInterfaceStyle == .dark
              ? UIColor(Color(hex: dark))
              : UIColor(Color(hex: light))
      })
  }
}
