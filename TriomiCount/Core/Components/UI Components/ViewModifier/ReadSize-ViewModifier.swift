//
//  ReadSize-ViewModifier.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 30.10.22.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geo in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geo.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}
