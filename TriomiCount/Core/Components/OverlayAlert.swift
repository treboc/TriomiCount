//
//  OverlayAlert.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 05.04.22.
//

import SwiftUI

struct OverlayedAlert: ViewModifier {
  let message: String
  let bool: Bool

  func body(content: Content) -> some View {
    content
      .overlay(
        Text(message)
          .textCase(.uppercase)
          .font(.subheadline)
          .foregroundColor(.red)
          .offset(x: 25, y: 20)
          .opacity(bool ? 0 : 1)
          .animation(.default, value: bool),
        alignment: .bottomLeading
      )
  }
}

extension View {
  func overlayedAlert(with message: String, bool: Bool) -> some View {
    modifier(OverlayedAlert(message: message, bool: bool))
  }
}
