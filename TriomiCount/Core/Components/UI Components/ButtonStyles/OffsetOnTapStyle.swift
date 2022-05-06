//
//  OffsetOnTapStyle.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 12.03.22.
//

import SwiftUI

extension ButtonStyle where Self == OffsetOnTapStyle {
  static var offsetStyle: Self {
    return .init()
  }
}

struct OffsetOnTapStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled

  let height: CGFloat = 55

  let primaryColor: Color
  let secondaryColor: Color
  var borderColor: Color = .secondaryBackground

  init(primaryColor: Color = Color.primaryAccentColor,
       secondaryColor: Color = Color.secondaryAccentColor,
       role: ButtonRole = .cancel) {
    if role == .destructive {
      self.primaryColor = Color.destructiveButtonPrimaryColor
      self.secondaryColor = Color.destructiveButtonSecondaryColor
      self.borderColor = .secondaryBackground.opacity(0.4)
    } else {
      self.primaryColor = primaryColor
      self.secondaryColor = secondaryColor
    }
  }

  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      RoundedRectangle(cornerRadius: 20)
        .fill(primaryColor.opacity(0.25))
        .frame(height: height)
        .shadow(color: .gray.opacity(0.8), radius: configuration.isPressed ? 0 : 3, x: 0, y: 0)
        .animation(.easeIn(duration: 0.1), value: configuration.isPressed)

      configuration.label
        .font(.headline)
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .background(primaryColor)
        .cornerRadius(20)
        .foregroundColor(.white)
        .font(.headline.bold())
        .offset(y: configuration.isPressed ? 0 : -4)
    }
    .onChange(of: configuration.isPressed) { newValue in
      if newValue {
        HapticManager.shared.impact(style: .light)
      }
    }
    .if(!isEnabled) { view in
      view.grayscale(1)
    }
  }
}
