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
          .buttonStyle(.shadowed)
          .padding(.horizontal)
        }
      }
      .padding()
      .frame(maxWidth: .infinity)
      .padding(.horizontal)
    }
  }
}
