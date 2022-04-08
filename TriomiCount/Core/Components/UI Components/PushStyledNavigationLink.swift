//
//  PushStyledNavigationLink.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//

import SwiftUI

struct PushStyledNavigationLink<Destination: View>: View {
  let title: LocalizedStringKey
  let destination: Destination

  init(title: LocalizedStringKey, @ViewBuilder destination: () -> Destination) {
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
