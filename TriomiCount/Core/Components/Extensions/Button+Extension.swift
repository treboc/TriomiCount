//
//  Button+Extension.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 12.05.22.
//

import SwiftUI
import SFSafeSymbols

extension Button where Label == Image {
  init(iconName: SFSymbol, action: @escaping () -> Void) {
    self.init(action: action) {
      Image(systemSymbol: iconName)
    }
  }
}
