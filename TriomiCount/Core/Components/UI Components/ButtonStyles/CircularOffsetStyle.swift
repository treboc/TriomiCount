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
    ZStack {
      Circle()
        .fill(.black.opacity(0.5))
        .frame(width: 40, height: 40)
        .shadow(color: .black.opacity(1), radius: configuration.isPressed ? 0 : 3, x: 0, y: 0)
        .animation(.easeIn(duration: 0.1), value: configuration.isPressed)

      configuration.label
        .frame(width: 40, height: 40)
        .background(primaryColor)
        .clipShape(Circle())
        .foregroundColor(.white)
        .font(.system(size: 20))
        .offset(y: configuration.isPressed ? 0 : -4)
    }
  }
}
