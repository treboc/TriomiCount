//
//  PlayedCardPicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 13.03.22.
//

#warning("Think about refactor this to act like a generic segmented view.")

import SwiftUI

struct PlayedCardPicker: View {
  @Binding var selection: Bool
  @Binding var timesDrawn: Int

  var body: some View {
    HStack {
      ButtonToPick(title: "Yes", selection: $selection, timesDrawn: $timesDrawn) {
        self.selection = true
      }

      ButtonToPick(title: "No", selection: $selection, timesDrawn: $timesDrawn) {
        self.selection = false
      }
    }
    .animation(.default, value: selection)
    .onChange(of: selection) { _ in
      HapticManager.shared.impact(style: .soft)
    }
  }

  struct ButtonToPick: View {
    let title: LocalizedStringKey
    @Binding var selection: Bool
    @Binding var timesDrawn: Int
    let action: () -> Void

    var isSelected: Bool {
      if title == "Yes" && selection {
        return true
      } else if title == "No" && !selection {
        return true
      }
      return false
    }

    var body: some View {
      Text(title)
        .font(.headline)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.primaryAccentColor : Color.secondaryBackground)
        .cornerRadius(20)
        .foregroundColor(.label)
        .font(.headline.bold())
        .overlay(
          RoundedRectangle(cornerRadius: 15, style: .continuous)
            .strokeBorder(Color.secondaryBackground, lineWidth: 2)
        )
        .offset(y: (isSelected ? 0 : -4))
        .background(
          isSelected ?
          Color.secondaryAccentColor
            .frame(height: 55)
            .cornerRadius(15)
          :
          Color.tertiaryBackground
          .frame(height: 55)
          .cornerRadius(15)
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




