//
//  FTTextField.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import SwiftUI

struct FTTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var errorMessage: String? = nil
    var keyboardType: UIKeyboardType = .default

    @State private var isSecureTextVisible = false
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: FTSpacing.xs) {
            Text(title)
                .font(FTFont.body2())
                .foregroundColor(FTColor.textPrimary)

            HStack {
                if isSecure && !isSecureTextVisible {
                    SecureField(placeholder, text: $text)
                        .focused($isFocused)
                } else {
                    TextField(placeholder, text: $text)
                        .keyboardType(keyboardType)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .focused($isFocused)
                }

                if isSecure {
                    Button {
                        isSecureTextVisible.toggle()
                    } label: {
                        Image(systemName: isSecureTextVisible ? "eye.slash" : "eye")
                            .foregroundColor(FTColor.textHint)
                    }
                }
            }
            .font(FTFont.body1())
            .padding(.horizontal, FTSpacing.md)
            .frame(height: 52)
            .background(FTColor.background)
            .cornerRadius(FTRadius.small)
            .overlay(
                RoundedRectangle(cornerRadius: FTRadius.small)
                    .stroke(borderColor, lineWidth: 1)
            )

            if let errorMessage = errorMessage, !errorMessage.isEmpty {
                HStack(spacing: FTSpacing.xxs) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .font(.system(size: 14))
                    Text(errorMessage)
                        .font(FTFont.caption())
                }
                .foregroundColor(FTColor.error)
            }
        }
    }

    private var borderColor: Color {
        if errorMessage != nil && !errorMessage!.isEmpty {
            return FTColor.error
        }
        return isFocused ? FTColor.primary : FTColor.divider
    }
}

#Preview {
    VStack(spacing: 20) {
        FTTextField(
            title: "이메일",
            placeholder: "example@email.com",
            text: .constant(""),
            keyboardType: .emailAddress
        )

        FTTextField(
            title: "비밀번호",
            placeholder: "최소 6자 이상",
            text: .constant(""),
            isSecure: true
        )

        FTTextField(
            title: "비밀번호",
            placeholder: "최소 6자 이상",
            text: .constant("abc"),
            isSecure: true,
            errorMessage: "비밀번호가 너무 짧습니다"
        )
    }
    .padding()
    .background(Color.gray.opacity(0.1))
}
