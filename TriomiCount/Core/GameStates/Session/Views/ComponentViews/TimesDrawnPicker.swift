//
//  TimesDrawnPicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 13.03.22.
//

import SwiftUI

struct TimesDrawnPicker: View {
  @Binding var selection: Int
  @Namespace private var buttonBackground
  let color: UIColor

  var body: some View {
    HStack {
      ForEach(0..<4, id: \.self) { number in
        ButtonToPick(namespace: buttonBackground,
                     selection: $selection,
                     number: number,
                     color: color) {
          selection = number
        }
      }
      .animation(.interpolatingSpring(stiffness: 300, damping: 15), value: selection)
      .onChange(of: selection) { _ in
        HapticManager.shared.impact(style: .soft)
      }
    }
  }

  struct ButtonToPick: View {
    let namespace: Namespace.ID
    @Binding var selection: Int
    let number: Int
    let color: UIColor
    let action: () -> Void

    var textColor: Color {
      isSelected ? .white : .primary
    }

    var isSelected: Bool {
      number == selection
    }

    var body: some View {
      ZStack {
        if isSelected {
          RoundedRectangle(cornerRadius: Constants.cornerRadius, style: .circular)
            .fill(Color.primaryAccentColor)
            .shadow(radius: Constants.shadowRadius)
            .matchedGeometryEffect(id: "background", in: namespace)
        }

        Text("\(number)")
          .foregroundColor(textColor)
          .font(.headline.bold())
          .animation(.none, value: number)
      }
      .frame(height: Constants.buttonHeight)
      .frame(maxWidth: .infinity)
      .contentShape(Rectangle())
      .onTapGesture {
        action()
      }
      .disabled(isSelected)
    }
  }
}
