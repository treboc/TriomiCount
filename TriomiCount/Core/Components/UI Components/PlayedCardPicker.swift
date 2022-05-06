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

  var body: some View {
    HStack {
      ButtonToPick(title: L10n.yes, selection: $selection, timesDrawn: $timesDrawn) {
        self.selection = true
      }

      ButtonToPick(title: L10n.no, selection: $selection, timesDrawn: $timesDrawn) {
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
    let action: () -> Void

    let height: CGFloat = 55

    var isSelected: Bool {
      if title == L10n.yes && selection {
        return true
      } else if title == L10n.no && !selection {
        return true
      }
      return false
    }

    var firstBackgroundColor: Color {
      isSelected ? Color.secondaryAccentColor : Color.primaryAccentColor
    }
    var secondBackgroundColor: Color {
      isSelected ? .secondaryAccentColor : .tertiaryAccentColor
    }

    var body: some View {
      Text(title)
        .font(.headline)
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .background(firstBackgroundColor)
        .cornerRadius(20)
        .foregroundColor(.white)
        .font(.headline.bold())
        .offset(y: (isSelected ? 0 : -4))
        .background(
          secondBackgroundColor
            .opacity(0.25)
            .frame(height: height)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
        )
        .onTapGesture {
          if timesDrawn == 3 {
            action()
          }
        }
        .if(timesDrawn != 3) { view in
          view.grayscale(1)
        }
    }
  }
}
