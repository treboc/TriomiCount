//
//  BonusEventPicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 05.04.22.
//

import SwiftUI

struct BonusEventPicker: View {
  @ObservedObject var viewModel: GameViewModel

  var body: some View {
    Button(viewModel.bonusEvent.rawValue) {
      viewModel.bonusEventPickerOverlayIsShown = true
    }
    .animation(.none, value: viewModel.bonusEvent.rawValue)
    .buttonStyle(.offsetStyle)
    .onChange(of: viewModel.bonusEvent) { _ in
      HapticManager.shared.impact(style: .light)
    }
  }

  struct SelectionOverlay: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
      ZStack {
        Color.black.opacity(0.01).ignoresSafeArea()
          .onTapGesture {
            viewModel.bonusEventPickerOverlayIsShown = false
          }

        VStack(spacing: 15) {
          ForEach(GameViewModel.BonusEvent.allCases, id: \.self) { bonusEvent in
            Button(bonusEvent.rawValue) {
              viewModel.bonusEvent = bonusEvent
              viewModel.bonusEventPickerOverlayIsShown = false
            }
            .buttonStyle(.offsetStyle)
          }
        }
        .padding(50)
        .frame(maxWidth: .infinity)
        .background(Color.primaryBackground)
        .cornerRadius(20)
        .overlay(
          RoundedRectangle(cornerRadius: 20)
            .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
        )
        .overlay(
          Button(action: {
            viewModel.bonusEventPickerOverlayIsShown = false
          }, label: {
            Label("Close BonusEventPicker", systemImage: "xmark")
              .labelStyle(.iconOnly)
          })
            .buttonStyle(.circularOffsetStyle)
            .offset(x: 0, y: -20)
            .scaleEffect(0.8), alignment: .topTrailing
        )
        .padding(.horizontal, 50)
      }
    }
  }
}