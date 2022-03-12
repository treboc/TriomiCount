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

  let primaryColor: Color
  let secondaryColor: Color

  init(_ primaryColor: Color = Color.accentColor, _ secondaryColor: Color = Color.secondaryAccentColor) {
    self.primaryColor = primaryColor
    self.secondaryColor = secondaryColor
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(.headline)
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(primaryColor)
      .cornerRadius(20)
      .foregroundColor(.label)
      .font(.headline.bold())
      .overlay(
        RoundedRectangle(cornerRadius: 15, style: .continuous)
          .strokeBorder(Color.secondaryBackground, lineWidth: 2)
      )
      .offset(y: configuration.isPressed ? 0 : -4)
      .background(
        secondaryColor
          .frame(height: 55)
          .cornerRadius(15)
      )
      .animation(.none, value: configuration.isPressed)
      .padding(.horizontal)
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
