//
//  HeaderView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 12.05.22.
//

import SwiftUI

struct HeaderView<LeadingButton: View, TrailingButton: View>: View {
  let title: String
  var leadingButton: LeadingButton?
  var trailingButton: TrailingButton?

  init(title: String, @ViewBuilder leadingButton: () -> LeadingButton, @ViewBuilder trailingButton: () -> TrailingButton) {
    self.title = title
    self.trailingButton = trailingButton()
    self.leadingButton = leadingButton()
  }

  init(title: String) where LeadingButton == EmptyView, TrailingButton == EmptyView {
    self.title = title
  }

  init(title: String, @ViewBuilder leadingButton: () -> LeadingButton) where TrailingButton == EmptyView {
    self.title = title
    self.leadingButton = leadingButton()
  }

  var body: some View {
    Text(title)
      .foregroundColor(.primary)
      .font(.headline)
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        Rectangle()
          .fill(.regularMaterial)
          .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
          .shadow(color: Color(uiColor: .black).opacity(0.5), radius: 8, x: 0, y: 2.5)
          .ignoresSafeArea(.all, edges: .top)
      )
      .overlay(
        leadingButton
          .padding(.leading)
          .foregroundColor(.primary)
          .font(.headline), alignment: .leading)
      .overlay(
        trailingButton
          .padding(.trailing)
          .foregroundColor(.primary)
          .font(.headline), alignment: .trailing)
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    HeaderView(title: L10n.sessions) {
      Button(iconName: .infinity) {
        //
      }
    }
  }
}
