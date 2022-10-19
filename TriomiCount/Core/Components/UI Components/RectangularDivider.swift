//
//  RectangularDivider.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 19.10.22.
//

import SwiftUI

struct RectangularDivider: View {
  var body: some View {
    Rectangle()
      .fill(Color.accentColor)
      .frame(height: 2)
      .frame(maxWidth: .infinity)
      .shadow(radius: 3, y: 3)
  }
}

struct RectangularDivider_Previews: PreviewProvider {
  static var previews: some View {
    RectangularDivider()
  }
}
