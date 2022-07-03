//
//  BonusEventPicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 05.04.22.
//

import SwiftUI

struct BonusEventPicker: View {
  @Binding var bonusEvent: SessionViewModel.BonusEvent
  @Binding var bonusEventPickerOverlayIsShown: Bool

  var body: some View {
    Button(bonusEvent.description) {
      withAnimation {
        bonusEventPickerOverlayIsShown = true
      }
    }
    .animation(.none, value: bonusEvent.description)
    .buttonStyle(.shadowed)
    .onChange(of: bonusEvent) { _ in
      HapticManager.shared.impact(style: .light)
    }
  }

  struct SelectionOverlay: View {
    @Binding var bonusEvent: SessionViewModel.BonusEvent
    @Binding var bonusEventPickerOverlayIsShown: Bool

    var body: some View {
      VStack(spacing: 15) {
        ForEach(SessionViewModel.BonusEvent.allCases, id: \.self) { bonusEvent in
          Button(bonusEvent.description) {
            withAnimation {
              self.bonusEvent = bonusEvent
              bonusEventPickerOverlayIsShown = false
            }
          }
          .buttonStyle(.offsetStyle)
          .padding(.horizontal)
        }
      }
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .fill(.ultraThinMaterial)
          .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
      )
      .padding(.horizontal)
    }
  }
}
