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
  }

  struct ButtonToPick: View {
    let number: Int
    @Binding var selection: Int

    var isToggled: Bool {
      number == selection
    }

    let action: () -> Void
    var firstBackgroundColor: Color {
      isToggled ? Color.secondaryAccentColor : Color.primaryAccentColor
    }
    var secondBackgroundColor: Color {
      isToggled ? .secondaryAccentColor : .tertiaryAccentColor
    }

    var body: some View {
      Text("\(number)")
        .font(.headline)
        .frame(height: Constants.buttonHeight)
        .frame(maxWidth: .infinity)
        .background(firstBackgroundColor)
        .cornerRadius(Constants.cornerRadius)
        .foregroundColor(.white)
        .font(.headline.bold())
        .offset(y: isToggled ? 0 : -4)
        .background(
          secondBackgroundColor
            .opacity(0.25)
            .frame(height: Constants.buttonHeight)
            .cornerRadius(Constants.cornerRadius)
            .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
        )
        .onTapGesture {
          action()
        }
    }
  }
}
