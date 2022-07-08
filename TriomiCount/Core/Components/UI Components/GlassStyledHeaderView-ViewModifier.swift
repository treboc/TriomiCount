//
//  GlassStyledHeaderView-ViewModifier.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 08.05.22.
//

import Introspect
import SwiftUI

extension View {
  func glassStyled(withColor color: UIColor) -> some View {
    modifier(GlassStyledHeader(color: color))
  }
}

struct GlassStyledHeader: ViewModifier {
  let color: UIColor

  func body(content: Content) -> some View {
    content
      .foregroundColor(color.isDarkColor ? .white : .black)
      .font(.headline)
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        Rectangle()
          .fill(
            LinearGradient(
              colors: [
                Color(uiColor: color),
                Color(uiColor: color),
                Color(uiColor: color.isDarkColor
                      ? color.shade(.darkest)
                      : color.shade(.lightest)
                     )
              ],
              startPoint: .topLeading,
              endPoint: .bottomTrailing)
          )
          .cornerRadius(Constants.cornerRadius)
          .shadow(radius: 5)
      )
      .padding(.horizontal)
  }
}
