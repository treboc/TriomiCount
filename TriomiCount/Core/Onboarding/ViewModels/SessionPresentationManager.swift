//
//  SessionPresentationManager.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 19.10.22.
//

import Foundation

final class SessionPresentationManager: ObservableObject {
  @Published var sessionIsShown: Bool = false

  func hideSession() {
    sessionIsShown = false
  }

  func showSession() {
    sessionIsShown = true
  }
}
