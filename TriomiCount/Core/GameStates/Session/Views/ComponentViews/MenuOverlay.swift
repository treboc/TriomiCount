//
//  MenuOverlay.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 16.05.22.
//

import SwiftUI

extension SessionView {
  /// An overlaying menu for the session view.
  /// Pops up on tap of the button in the lower trailing corner.
  /// Shows buttons for ending or leaving the session and undo the last turn, if any were made in the current session.
  struct MenuOverlay: View {
    @StateObject var viewModel: SessionViewModel
    @Binding var menuIsShown: Bool
    @State private var isAnimated: Bool = false

    @Environment(\.dismiss) var dismiss

    var exitSession: () -> Void
    var toggleScaleAnimation: () -> Void

    var body: some View {
      ZStack(alignment: .bottomTrailing) {
        Color.black.opacity(0.4)
          .ignoresSafeArea()
          .onTapGesture {
            closeMenu()
          }

        ZStack(alignment: .bottomTrailing) {
          if !viewModel.session.turnsArray.isEmpty {
            endSessionButton
            undoButton
          }
          exitSessionButton
          closeMenuButton
        }
        .padding(.trailing)
        .padding(.bottom)
      }
      .onAppear {
        withAnimation {
          isAnimated = true
        }
      }
    }

    private var endSessionButton: some View {
      HStack {
        Text(L10n.SessionView.EndSessionButton.labelText)

        Button(iconName: .stopFill) {
          viewModel.showEndSessionAlert.toggle()
          HapticManager.shared.notification(type: .success)
        }
        .buttonStyle(.circular)
        .disabled(viewModel.session.turns?.count == 0)
      }
      .padding(.leading)
      .background(Capsule().fill(.thinMaterial))
      .animation(.spring(), value: isAnimated)
      .offset(isAnimated ? CGSize(width: 0, height: -100) : .zero)
    }

    private var exitSessionButton: some View {
      HStack {
        Text(L10n.SessionView.ExitSessionButton.labelText)

        Button(iconName: .houseFill) {
          dismiss()
        }
        .buttonStyle(.circular)
      }
      .padding(.leading)
      .background(Capsule().fill(.thinMaterial))
      .animation(.spring(), value: isAnimated)
      .offset(isAnimated ? CGSize(width: -25, height: -50) : .zero)
    }

    private var undoButton: some View {
      HStack {
        Text(L10n.SessionView.UndoButton.labelText)

        Button(iconName: .arrowCounterclockwise) {
          withAnimation {
            viewModel.undoLastTurn()
            menuIsShown = false
          }
          HapticManager.shared.impact(style: .rigid)
          toggleScaleAnimation()
        }
        .buttonStyle(.circular)
        .disabled(viewModel.session.turns?.count == 0)
      }
      .padding(.leading)
      .background(Capsule().fill(.thinMaterial))
      .animation(.spring(), value: isAnimated)
      .offset(isAnimated ? CGSize(width: -50, height: 0) : .zero)
    }

    private var closeMenuButton: some View {
      Button(iconName: .xCircleFill) {
        closeMenu()
      }
      .buttonStyle(.circular)
      .transition(.opacity)
      .opacity(isAnimated ? 1 : 0)
    }

    func closeMenu() {
      withAnimation {
        isAnimated = false
      }

      menuIsShown = false
    }
  }
}
