//
//  PrimaryNavigationLink.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//

import SwiftUI

struct PrimaryNavigationLink<Destination: View>: View {
  let destinationView: Destination
  let labelTextStringKey: LocalizedStringKey
  
  var body: some View {
    NavigationLink {
      destinationView
    } label: {
      Text(labelTextStringKey)
        .fontWeight(.semibold)
    }
    .buttonStyle(.offsetStyle)
  }
}
