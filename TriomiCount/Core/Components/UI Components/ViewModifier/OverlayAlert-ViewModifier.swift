//
//  OverlayAlert.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 05.04.22.
//

import SwiftUI

struct OverlayedAlert: ViewModifier {
  let message: String
  let alertIsShown: Bool

  func body(content: Content) -> some View {
    content
      .overlay(
        alertIsShown ?
        Text(message)
          .font(.subheadline)
          .foregroundColor(.red)
          .offset(y: 40)
          .transition(.opacity.combined(with: .move(edge: .leading)))
        : nil ,
        alignment: .bottomLeading
      )
  }
}

extension View {
  func overlayedAlert(with message: String, alertIsShown: Bool) -> some View {
    modifier(OverlayedAlert(message: message, alertIsShown: alertIsShown))
  }
}
