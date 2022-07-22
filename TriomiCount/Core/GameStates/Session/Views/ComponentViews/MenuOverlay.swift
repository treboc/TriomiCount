//
//  MenuOverlay.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 16.05.22.
//

import SFSafeSymbols
import SwiftUI

extension SessionView {
  /// An overlaying menu for the session view.
  /// Pops up on tap of the button in the lower trailing corner.
  /// Shows buttons for ending or leaving the session and undo the last turn, if any were made in the current session.
  struct MenuOverlay: View {
    @EnvironmentObject var viewModel: SessionViewModel
    @Binding var menuIsShown: Bool
    @State private var isAnimated: Bool = false

    @Environment(\.dismiss) var dismiss
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
            // End Session
            button(symbol: .stopFill, title: L10n.SessionView.EndSessionButton.labelText) {
              viewModel.showEndSessionAlert.toggle()
              HapticManager.shared.notification(type: .success)
            }
            .offset(isAnimated ? CGSize(width: 0, height: -(Constants.buttonHeight + 10) * 2) : .zero)

            // Undo Last Turn
            button(symbol: .arrowCounterclockwise, title: L10n.SessionView.UndoButton.labelText) {
              viewModel.undoLastTurn()
              menuIsShown = false
            }
            .offset(isAnimated ? CGSize(width: 0, height: -(Constants.buttonHeight + 10))  : .zero)
          }

          // Exit Session
          button(symbol: .houseFill, title: L10n.SessionView.ExitSessionButton.labelText, action: dismiss.callAsFunction)

          // Close Menu
          closeMenuButton
        }
        .padding([.trailing, .bottom])
      }
      .onAppear {
        withAnimation {
          isAnimated = true
        }
      }
    }

    private func button(symbol: SFSymbol, title: String? = nil, action: @escaping () -> Void) -> some View {
      HStack {
        if let title = title {
          Text(title)
        }

        Button(iconName: symbol) {
          action()
        }
        .buttonStyle(.circular)
      }
      .padding(.leading)
      .background(Capsule().fill(.thinMaterial))
      .animation(.spring(), value: isAnimated)
      .offset(isAnimated ? CGSize(width: 0, height: -(Constants.buttonHeight + 10)) : .zero)
    }

    private var closeMenuButton: some View {
      Button(iconName: .xmark) {
        closeMenu()
      }
      .buttonStyle(.shadowed)
      .transition(.opacity)
      .opacity(isAnimated ? 1 : 0)
      .frame(width: Constants.buttonHeight, height: Constants.buttonHeight)
    }

    func closeMenu() {
      withAnimation {
        isAnimated = false
      }

      menuIsShown = false
    }
  }
}
