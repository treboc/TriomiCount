//
//  MenuOverlay.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 16.05.22.
//

import SwiftUI

extension SessionView {
  struct MenuOverlay: View {
    @StateObject var viewModel: SessionViewModel
    @Binding var menuIsShown: Bool
    @State private var isAnimated: Bool = false
    var exitSession: () -> Void
    var toggleScaleAnimation: () -> Void

    var body: some View {
      ZStack(alignment: .bottomTrailing) {
        Color.black.opacity(0.001)
          .onTapGesture {
            closeMenu()
          }

        VStack(alignment: .trailing) {
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
        .buttonStyle(.circularOffsetStyle)
        .disabled(viewModel.session.turns?.count == 0)
      }
      .padding(.leading)
      .background(Capsule().fill(.thinMaterial))
      .animation(.spring().delay(0.4), value: isAnimated)
      .offset(x: isAnimated ? 0 : 400)
    }

    private var undoButton: some View {
      HStack {
        Text(L10n.SessionView.UndoButton.labelText)

        Button(iconName: .arrowCounterclockwise) {
          viewModel.undoLastTurn()
          HapticManager.shared.notification(type: .success)
          toggleScaleAnimation()
          withAnimation {
            menuIsShown.toggle()
          }
        }
        .buttonStyle(.circularOffsetStyle)
        .disabled(viewModel.session.turns?.count == 0)
      }
      .padding(.leading)
      .background(Capsule().fill(.thinMaterial))
      .animation(.spring().delay(0.2), value: isAnimated)
      .offset(x: isAnimated ? 0 : 400)
    }

    private var exitSessionButton: some View {
      HStack {
        Text(L10n.SessionView.ExitSessionButton.labelText)

        Button(iconName: .houseFill) {
          viewModel.exitSessionButtonTapped(exitSession: exitSession)
        }
        .buttonStyle(.circularOffsetStyle)
      }
      .padding(.leading)
      .background(Capsule().fill(.thinMaterial))
      .animation(.spring(), value: isAnimated)
      .offset(x: isAnimated ? 0 : 400)
    }

    private var closeMenuButton: some View {
      HStack {
        Text("Close")
        Button(iconName: .xCircleFill) {
          closeMenu()
        }
        .buttonStyle(.circularOffsetStyle)
      }
      .padding(.leading)
      .background(Capsule().fill(.thinMaterial))
      .animation(.easeOut(duration: 0.1), value: isAnimated)
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
