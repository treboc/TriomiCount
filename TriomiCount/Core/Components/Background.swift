//
//  Background.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 03.07.22.
//

import SwiftUI

struct Background: View {
  var body: some View {
    LinearGradient(colors: [.primaryBackground.opacity(0.6), .primaryBackground.opacity(0.1)],
                   startPoint: .top,
                   endPoint: .bottom)
    .ignoresSafeArea()
  }
}
