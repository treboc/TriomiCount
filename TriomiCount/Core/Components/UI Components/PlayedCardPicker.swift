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

    let height: CGFloat = UIScreen.main.bounds.height / 18

    var isSelected: Bool {
      if title == "Yes" && selection {
        return true
      } else if title == "No" && !selection {
        return true
      }
      return false
    }

    var backgroundColor: Color {
      isSelected ? .secondaryAccentColor : .tertiaryBackground
    }

    var body: some View {
      Text(title)
        .font(.headline)
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .background(isSelected ? Color.primaryAccentColor : Color.secondaryBackground)
        .cornerRadius(20)
        .foregroundColor(.white)
        .font(.headline.bold())
        .overlay(
          RoundedRectangle(cornerRadius: 20, style: .continuous)
            .strokeBorder(Color.secondaryBackground, lineWidth: 2)
        )
        .offset(y: (isSelected ? 0 : -4))
        .background(
          backgroundColor
            .frame(height: height)
            .cornerRadius(20)
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
