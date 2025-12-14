//
//  TreeProgress.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import Foundation

struct FamilyTree: Equatable, Sendable {
    let id: UUID
    let familyId: UUID
    let stage: TreeStage
    let totalAnswers: Int
    let consecutiveDays: Int
    let lastUpdated: Date
  
  init(
    id: UUID = UUID(),
    familyId: UUID = UUID(),
    stage: TreeStage = .seed,
    totalAnswers: Int = 0,
    consecutiveDays: Int = 0,
    lastUpdated: Date = .now
  ) {
    self.id = id
    self.familyId = familyId
    self.stage = stage
    self.totalAnswers = totalAnswers
    self.consecutiveDays = consecutiveDays
    self.lastUpdated = lastUpdated
  }
}

enum TreeStage: Int, Sendable {
    case seed = 0        // 씨앗 (0일)
    case sprout = 1      // 새싹 (1-10일)
    case sapling = 2     // 어린 나무 (11-30일)
    case youngTree = 3   // 청년 나무 (31-60일)
    case matureTree = 4  // 성목 (61-100일)
    case flowering = 5   // 꽃 피는 나무 (100일+)
    case bound = 6
}

