//
//  FamTreeApp.swift
//  FamTree
//
//  Created by 최용헌 on 12/10/25.
//

import SwiftUI
import ComposableArchitecture

@main
struct FamTreeApp: App {
  let store = Store(initialState: HomeFeature.State()) {
    HomeFeature()
  }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
