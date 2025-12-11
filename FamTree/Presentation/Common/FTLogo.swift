//
//  FTLogo.swift
//  FamTree
//
//  Created by 최용헌 on 12/11/25.
//

import SwiftUI

struct FTLogo: View {
    enum Size {
        case small
        case medium
        case large

        var dimension: CGFloat {
            switch self {
            case .small: return 48
            case .medium: return 80
            case .large: return 120
            }
        }
    }

    let size: Size

    init(size: Size = .medium) {
        self.size = size
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(FTColor.primaryLight.opacity(0.3))
                .frame(width: size.dimension, height: size.dimension)

            Image(systemName: "leaf.fill")
                .resizable()
                .scaledToFit()
                .frame(width: size.dimension * 0.5, height: size.dimension * 0.5)
                .foregroundColor(FTColor.primary)
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        FTLogo(size: .small)
        FTLogo(size: .medium)
        FTLogo(size: .large)
    }
}
