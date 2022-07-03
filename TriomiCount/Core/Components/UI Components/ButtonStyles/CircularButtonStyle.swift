//
//  CircularOffsetStyle.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 12.03.22.
//

import SwiftUI

extension ButtonStyle where Self == CircularButtonStyle {
  static var circular: Self {
    return .init()
  }
}

struct CircularButtonStyle: ButtonStyle {
  @State fileprivate var tap = false

  let primaryColor: Color
  let secondaryColor: Color

  init(_ primaryColor: Color = Color.primaryAccentColor, _ secondaryColor: Color = Color.secondaryAccentColor) {
    self.primaryColor = primaryColor
    self.secondaryColor = secondaryColor
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(width: Constants.buttonHeight, height: Constants.buttonHeight)
      .background(primaryColor)
      .clipShape(Circle())
      .foregroundColor(.white)
      .font(.system(size: 16))
      .scaleEffect(configuration.isPressed ? 0.97 : 1)
      .shadow(radius: configuration.isPressed ? 0 : 3)
      .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
  }
}
