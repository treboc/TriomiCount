//
//  CustomModifiers.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 08.05.22.
//

import SwiftUI

extension View {
  func glassStyled() -> some View {
    modifier(GlassStyledHeader())
  }
}

struct GlassStyledHeader: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.primary)
      .font(.headline)
      .padding()
    //      .padding(.vertical)
      .frame(maxWidth: .infinity)
      .background(
        Rectangle()
          .fill(Color.secondaryBackground)
          .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
          .shadow(color: Color(uiColor: .black).opacity(0.5), radius: 8, x: 0, y: 2.5)
          .ignoresSafeArea(.all, edges: .top)
      )
  }
}
