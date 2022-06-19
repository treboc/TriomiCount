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
  @State fileprivate var tap = false

  let primaryColor: Color
  let secondaryColor: Color

  init(_ primaryColor: Color = Color.primaryAccentColor, _ secondaryColor: Color = Color.secondaryAccentColor) {
    self.primaryColor = primaryColor
    self.secondaryColor = secondaryColor
  }

  func makeBody(configuration: Configuration) -> some View {
    ZStack {
      Circle()
        .fill(.black.opacity(0.2))
        .frame(width: Constants.buttonHeight, height: Constants.buttonHeight)
        .shadow(color: .black.opacity(1), radius: configuration.isPressed ? 0 : 3, x: 0, y: 0)
        .offset(y: 4)

      configuration.label
        .frame(width: Constants.buttonHeight, height: Constants.buttonHeight)
        .background(primaryColor)
        .clipShape(Circle())
        .foregroundColor(.white)
        .font(.system(size: 16))
        .offset(y: configuration.isPressed ? 4 : 0)
    }
    .animation(.easeInOut(duration: 0.3), value: configuration.isPressed)
  }
}
