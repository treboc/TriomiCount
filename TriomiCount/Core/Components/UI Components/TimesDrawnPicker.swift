//
//  TimesDrawnPicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 13.03.22.
//

import SwiftUI

struct TimesDrawnPicker: View {
  @Binding var selection: Int

  var body: some View {
    HStack {
      ForEach(0..<4, id: \.self) { number in
        ButtonToPick(number: number, selection: $selection) {
          selection = number
        }
      }
    }
    .animation(.default, value: selection)
    .onChange(of: selection) { newValue in
      HapticManager.shared.impact(style: .light)
    }
  }

  struct ButtonToPick: View {
    let number: Int
    @Binding var selection: Int

    var isToggled: Bool {
      number == selection
    }

    let action: () -> Void
    var backgroundColor: Color {
      isToggled ? .secondaryAccentColor : .tertiaryBackground
    }

    var body: some View {
      Text("\(number)")
        .font(.headline)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(isToggled ? Color.primaryAccentColor : Color.secondaryBackground)
        .cornerRadius(15)
        .foregroundColor(.label)
        .font(.headline.bold())
        .overlay(
          RoundedRectangle(cornerRadius: 15, style: .continuous)
            .stroke(Color.secondaryBackground, lineWidth: 2)
        )
        .offset(y: isToggled ? 0 : -4)
        .background(
          backgroundColor
            .frame(height: 55)
            .cornerRadius(15)
        )
        .onTapGesture {
          action()
        }
    }
  }
}




