//
//  OffsetOnTapStyle.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 12.03.22.
//

import SwiftUI

extension ButtonStyle where Self == OffsetStyle {
  static var offsetStyle: Self {
    return .init()
  }
}

struct OffsetStyle: ButtonStyle {
  @Environment(\.isEnabled) var isEnabled

  let primaryColor: Color
  let secondaryColor: Color
  var borderColor: Color = .secondaryBackground

  public init(primaryColor: Color = Color.primaryAccentColor,
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
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .fill(.black.opacity(0.1))
        .frame(height: Constants.buttonHeight)
        .shadow(color: .black.opacity(1), radius: configuration.isPressed ? 0 : 3, x: 0, y: 0)
        .animation(.easeIn(duration: 0.1), value: configuration.isPressed)
        .offset(y: 4)

      configuration.label
        .font(.headline)
        .foregroundColor(.white)
        .frame(height: Constants.buttonHeight)
        .frame(maxWidth: .infinity)
        .background(primaryColor)
        .cornerRadius(Constants.cornerRadius)
        .font(.headline.bold())
        .offset(y: configuration.isPressed ? 4 : 0)
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
