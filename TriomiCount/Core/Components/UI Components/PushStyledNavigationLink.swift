//
//  PushStyledNavigationLink.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//

import SwiftUI

struct PushStyledNavigationLink<Destination: View>: View {
  let title: String
  let destination: Destination

  init(title: String, @ViewBuilder destination: () -> Destination) {
    self.destination = destination()
    self.title = title
  }

  var body: some View {
    NavigationLink {
      destination
    } label: {
      Text(title)
        .fontWeight(.semibold)
    }
    .buttonStyle(.offsetStyle)
  }
}
