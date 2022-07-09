//
//  PlayedCardPicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 13.03.22.
//

import SwiftUI

struct PlayedCardPicker: View {
  @Binding var selection: Bool
  @Binding var timesDrawn: Int
  let color: UIColor

  var body: some View {
    HStack {
      ButtonToPick(title: L10n.yes, selection: $selection, timesDrawn: $timesDrawn, color: color) {
        self.selection = true
      }

      ButtonToPick(title: L10n.no, selection: $selection, timesDrawn: $timesDrawn, color: color) {
        self.selection = false
      }
    }
    .animation(.default, value: selection)
    .onChange(of: selection) { _ in
      HapticManager.shared.impact(style: .soft)
    }
  }

  struct ButtonToPick: View {
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

    var firstBackgroundColor: Color {
      isSelected ? Color(uiColor: color) : Color.primaryAccentColor
    }
    var secondBackgroundColor: Color {
      isSelected ? .secondaryAccentColor : .tertiaryAccentColor
    }

    var body: some View {
      Button(action: action) {
        Text(title)
          .frame(height: Constants.buttonHeight)
          .frame(maxWidth: .infinity)
          .background(firstBackgroundColor)
          .cornerRadius(Constants.cornerRadius)
          .foregroundColor(isSelected ? color.isDarkColor ? .white : .black : .white)
          .font(.headline.bold())
          .offset(y: (isSelected ? 0 : -4))
          .background(
            secondBackgroundColor
              .opacity(0.25)
              .frame(height: Constants.buttonHeight)
              .cornerRadius(Constants.cornerRadius)
              .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
          )
      }
      .disabled(timesDrawn != 3)
      .buttonStyle(.plain)
    }
  }
}
