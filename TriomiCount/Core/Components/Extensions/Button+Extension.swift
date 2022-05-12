//
//  Button+Extension.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 12.05.22.
//

import SwiftUI
import SFSafeSymbols

/// https://www.swiftbysundell.com/tips/swiftui-extensions-using-generics/
extension Button where Label == Image {
  init(iconName: SFSymbol, action: @escaping () -> Void) {
    self.init(action: action) {
      Image(systemSymbol: iconName)
    }
  }
}
