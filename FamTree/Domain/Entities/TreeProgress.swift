//
//  TreeProgress.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import Foundation


/// 그룹에 따른 나무 성장
struct TreeProgress {
    let id: UUID
    let familyId: UUID
    let stage: TreeStage
    let totalAnswers: Int
    let consecutiveDays: Int
    let lastUpdated: Date
}

enum TreeStage: Int {
    case seed = 0        // 씨앗 (0일)
    case sprout = 1      // 새싹 (1-10일)
    case sapling = 2     // 어린 나무 (11-30일)
    case youngTree = 3   // 청년 나무 (31-60일)
    case matureTree = 4  // 성목 (61-100일)
    case flowering = 5   // 꽃 피는 나무 (100일+)
}

