//
//  LoginView.swift
//  FamTree
//
//  Created by 최용헌 on 12/12/25.
//

import SwiftUI
import ComposableArchitecture

// MARK: - Login View (Placeholder)
struct LoginView: View {
    var body: some View {
        VStack(spacing: FTSpacing.xl) {
            Spacer()
            
            FTLogo(size: .large)
            
            Text("FamTree")
                .font(FTFont.heading1())
                .foregroundColor(FTColor.textPrimary)
            
            Text("가족과 함께 추억을 쌓아보세요")
                .font(FTFont.body1())
                .foregroundColor(FTColor.textSecondary)
            
            Spacer()
            
            VStack(spacing: FTSpacing.md) {
                FTButton(
                  "로그인",
                    style: .primary,
                    action: {
                        // TODO: 로그인 화면으로 이동
                    }
                )
                
                FTButton(
                  "회원가입",
                    style: .secondary,
                    action: {
                        // TODO: 회원가입 화면으로 이동
                    }
                )
            }
            .padding(.horizontal, FTSpacing.xl)
            .padding(.bottom, FTSpacing.xxl)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(FTColor.surface)
    }
}

#Preview {
  LoginView()
}
