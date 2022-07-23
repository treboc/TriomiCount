//
//  PlayedCardPicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 13.03.22.
//

import SwiftUI

struct PlayedCardPicker: View {
  @Namespace private var cardPicker
  @Binding var selection: Bool
  @Binding var timesDrawn: Int
  let color: UIColor

  var body: some View {
    HStack {
      ButtonToPick(namespace: cardPicker, title: L10n.yes, selection: $selection, timesDrawn: $timesDrawn, color: color) {
        self.selection = true
      }

      ButtonToPick(namespace: cardPicker, title: L10n.no, selection: $selection, timesDrawn: $timesDrawn, color: color) {
        self.selection = false
      }
    }
    .animation(.default, value: selection)
    .onChange(of: selection) { _ in
      HapticManager.shared.impact(style: .soft)
    }
  }

  struct ButtonToPick: View {
    let namespace: Namespace.ID
    let title: String
    @Binding var selection: Bool
    @Binding var timesDrawn: Int
    let color: UIColor
    let action: () -> Void

    var isSelected: Bool {
      if title == L10n.yes && selection {
        return true
      } else if title == L10n.no && !selection {
        return true
      }
      return false
    }

    var body: some View {
      ZStack {
        if isSelected {
          RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .circular)
            .fill(Color.primaryAccentColor)
            .shadow(radius: Constants.shadowRadius)
            .matchedGeometryEffect(id: "background", in: namespace)
        }

        Text(title)
          .foregroundColor(isSelected ? .white : .primary)
          .font(.headline.bold())
      }
      .frame(height: Constants.buttonHeight)
      .frame(maxWidth: .infinity)
      .contentShape(Rectangle())
      .onTapGesture {
        withAnimation(.linear) {
          action()
        }
      }
      .disabled(timesDrawn != 3)
      .grayscale(timesDrawn != 3 ? 1 : 0)
      .accessibilityAddTraits(.isButton)
      .accessibilityLabel(title)
    }
  }
}
