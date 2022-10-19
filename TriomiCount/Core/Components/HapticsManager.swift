//
//  HapticsManager.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 02.02.22.
//

import SwiftUI

class HapticManager {
  static let shared = HapticManager()

  func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: Constants.AppStorageKeys.hapticsEnabled) {
      let generator = UINotificationFeedbackGenerator()
      generator.notificationOccurred(type)
    }
  }

  func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
    if UserDefaults.standard.bool(forKey: Constants.AppStorageKeys.hapticsEnabled) {
      let generator = UIImpactFeedbackGenerator(style: style)
      generator.impactOccurred()
    }
  }
}
