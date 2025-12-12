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
  let store = Store(initialState: RootFeature.State()) {
    RootFeature()
  }
  
    var body: some Scene {
        WindowGroup {
          RootView(store: store)
        }
    }
}
