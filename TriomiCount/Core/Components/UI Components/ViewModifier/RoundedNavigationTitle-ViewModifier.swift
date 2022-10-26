//
//  RoundedNavigationTitle-ViewModifier.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 08.07.22.
//

import SwiftUI

extension View {
  func roundedNavigationTitle() -> some View {
    modifier(RoundedNavigationTitle())
  }
}

struct RoundedNavigationTitle: ViewModifier {
  func body(content: Content) -> some View {
    content
  }

  init() {
    var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
    titleFont = UIFont(descriptor:
                        titleFont.fontDescriptor
      .withDesign(.rounded)?
      .withSymbolicTraits(.traitBold)
                       ??
                       titleFont.fontDescriptor,
                       size: titleFont.pointSize
    )
    UINavigationBar.appearance().largeTitleTextAttributes = [.font: titleFont]
  }
}
