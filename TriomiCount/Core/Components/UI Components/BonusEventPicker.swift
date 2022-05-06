//
//  BonusEventPicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 05.04.22.
//

import SwiftUI

struct BonusEventPicker: View {
  @ObservedObject var viewModel: SessionViewModel

  var body: some View {
    Button(viewModel.bonusEvent.rawValue) {
      withAnimation {
        viewModel.bonusEventPickerOverlayIsShown = true
      }
    }
    .animation(.none, value: viewModel.bonusEvent.rawValue)
    .buttonStyle(.offsetStyle)
    .onChange(of: viewModel.bonusEvent) { _ in
      HapticManager.shared.impact(style: .light)
    }
  }

  struct SelectionOverlay: View {
    @ObservedObject var viewModel: SessionViewModel

    var body: some View {
      VStack(spacing: 15) {
        ForEach(SessionViewModel.BonusEvent.allCases, id: \.self) { bonusEvent in
          Button(bonusEvent.rawValue) {
            withAnimation {
              viewModel.bonusEvent = bonusEvent
              viewModel.bonusEventPickerOverlayIsShown = false
            }
          }
          .buttonStyle(.offsetStyle)
          .padding(.horizontal)
        }
      }
      .padding()
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.ultraThinMaterial)
          .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 0)
      )
      .padding(.horizontal)
    }

    private var closeButton: some View {
      Button(action: {
        viewModel.bonusEventPickerOverlayIsShown = false
      }, label: {
        Label("Close BonusEventPicker", systemImage: "xmark")
          .labelStyle(.iconOnly)
      })
      .buttonStyle(.circularOffsetStyle)
      .padding(5)
      .scaleEffect(0.8)
    }
  }
}
