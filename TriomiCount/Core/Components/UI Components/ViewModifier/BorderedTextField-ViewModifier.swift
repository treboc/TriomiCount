//
//  BorderedTextField-ViewModifier.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 08.07.22.
//

import SwiftUI

extension View {
  func borderedTextFieldStyle() -> some View {
    modifier(BorderedTextField())
  }
}

struct BorderedTextField: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.primary)
      .padding(.leading, 10)
      .frame(height: Constants.buttonHeight)
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .fill(.ultraThinMaterial)
          .shadow(radius: 3)
      )
  }
}
