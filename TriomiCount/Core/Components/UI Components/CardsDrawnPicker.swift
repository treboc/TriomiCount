//
//  CardsDrawnPicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 13.03.22.
//

#warning("Think about refactor this to act like a generic segmented view.")

import SwiftUI

struct CardsDrawnPicker: View {
  @State var isToggled: [Bool] = [false, false, false, false]
  @Binding var selection: Int

  var body: some View {
    HStack {
      ForEach(0..<4, id: \.self) { number in
        ButtonToPick(number: number, isToggled: $isToggled[number]) {
          toggleOnTap(number: number)
        }
        .tag(number)
      }
    }
    .animation(.default, value: selection)
    .onAppear {
      toggleOnTap(number: 0)
    }
    .onChange(of: selection) { newValue in
      toggleOnTap(number: newValue)
      HapticManager.shared.impact(style: .light)
    }
  }

  func toggleOnTap(number: Int) {
    self.selection = number

    for i in 0..<isToggled.count {
      if i == number {
        isToggled[i] = true
      } else {
        isToggled[i] = false
      }
    }
  }

  struct ButtonToPick: View {
    let number: Int
    @Binding var isToggled: Bool
    let action: () -> Void

    var body: some View {
      Text("\(number)")
        .font(.headline)
        .frame(height: 55)
        .frame(maxWidth: .infinity)
        .background(isToggled ? Color.primaryAccentColor : Color.secondaryBackground)
        .cornerRadius(20)
        .foregroundColor(.label)
        .font(.headline.bold())
        .overlay(
          RoundedRectangle(cornerRadius: 15, style: .continuous)
            .strokeBorder(Color.secondaryBackground, lineWidth: 2)
        )
        .offset(y: isToggled ? 0 : -4)
        .background(
          isToggled ?
          Color.secondaryAccentColor
            .frame(height: 55)
            .cornerRadius(15)
          :
            Color.tertiaryBackground
            .frame(height: 55)
            .cornerRadius(15)
        )
        .onTapGesture {
          action()
        }
    }
  }
}




