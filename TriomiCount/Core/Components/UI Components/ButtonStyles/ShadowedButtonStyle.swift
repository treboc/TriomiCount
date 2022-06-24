//
//  ShadowedButtonStyle.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 23.06.22.
//

import SwiftUI

extension ButtonStyle where Self == ShadowedStyle {
  static var shadowed: Self {
    return .init()
  }
}

struct ShadowedStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled

  let primaryColor: Color
  let secondaryColor: Color

  public init(primaryColor: Color = Color.primaryAccentColor,
              secondaryColor: Color = Color.secondaryAccentColor,
              role: ButtonRole = .cancel) {
    if role == .destructive {
      self.primaryColor = Color.destructiveButtonPrimaryColor
      self.secondaryColor = Color.destructiveButtonSecondaryColor
    } else {
      self.primaryColor = primaryColor
      self.secondaryColor = secondaryColor
    }
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.headline)
      .foregroundColor(isEnabled ? .primary : .systemGray6)
      .frame(minHeight: Constants.buttonHeight)
      .frame(maxWidth: .infinity)
      .background(isEnabled ? primaryColor : .systemGray3)
      .cornerRadius(Constants.cornerRadius)
      .font(.headline.bold())
      .shadow(radius: !isEnabled ? 0 : configuration.isPressed ? 0 : 3)
      .animation(.easeIn(duration: 0.1), value: configuration.isPressed)
  }
}
