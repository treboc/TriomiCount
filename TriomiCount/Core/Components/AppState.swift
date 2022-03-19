//
//  AppState.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 14.03.22.
//

import Foundation

// built to "navigate" back to the given view. When you want to get back, just create a new ID on the view.
final class AppState: ObservableObject {
  @Published var homeViewID: UUID = UUID()
  @Published var onboardingScreen: UUID = UUID()
}
