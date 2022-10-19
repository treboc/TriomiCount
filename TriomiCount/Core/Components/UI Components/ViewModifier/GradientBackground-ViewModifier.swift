//
//  GradientBackground-ViewModifier.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 03.07.22.
//

import SwiftUI

extension View {
  func gradientBackground() -> some View {
    modifier(GradientBackground())
  }
}

struct GradientBackground: ViewModifier {
  func body(content: Content) -> some View {
    content
      .background(
        LinearGradient(colors: [.primaryBackground,
                                .primaryBackground.opacity(0.2)],
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
      )
  }
}
