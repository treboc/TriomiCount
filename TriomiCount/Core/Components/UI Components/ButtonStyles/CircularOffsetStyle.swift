//
//  CircularOffsetStyle.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 12.03.22.
//

import SwiftUI

extension ButtonStyle where Self == CircularOffsetStyle {
  static var circularOffsetStyle: Self {
    return .init()
  }
}

struct CircularOffsetStyle: ButtonStyle {
  let primaryColor: Color
  let secondaryColor: Color

  init(_ primaryColor: Color = Color.primaryAccentColor, _ secondaryColor: Color = Color.secondaryAccentColor) {
    self.primaryColor = primaryColor
    self.secondaryColor = secondaryColor
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(width: 40, height: 40)
      .background(primaryColor)
      .clipShape(Circle())
      .foregroundColor(.white)
      .font(.headline.bold())
      .overlay(
        Circle()
          .strokeBorder(Color.secondaryBackground, lineWidth: 2)
      )
      .offset(y: configuration.isPressed ? 0 : -4)
      .background(
        secondaryColor
          .frame(height: 40)
          .clipShape(Circle())
      )
  }
}
