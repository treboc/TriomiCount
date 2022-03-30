//
//  GameView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 19.03.22.
//

import SwiftUI

struct GameView: View {
  @StateObject var vm: GameViewModel
  @EnvironmentObject var appState: AppState
  @Environment(\.dismiss) private var dismiss
  @State private var isAnimated: Bool = false

  var body: some View {
    VStack {
      header

      Spacer(minLength: 10)

      center

      Spacer(minLength: 10)

      VStack {
        nextPlayerButton
        HStack {
          exitGameButton
          endGameButton
        }
      }
    }
    .scaleEffect(isAnimated ? 1.05 : 1.0)
    .animation(.default, value: isAnimated)
    .onAppear(perform: vm.resetTurnState)
    .tint(.primaryAccentColor)
    .padding()
    .alert(AlertContext.exitGame.title, isPresented: $vm.showExitGameAlert) {
      Button("Cancel", role: .cancel) {}
      Button(AlertContext.exitGame.buttonTitle) {
        exitGame()
      }
    } message: {
      Text(AlertContext.exitGame.message)
    }
    .alert(AlertContext.endGame.title, isPresented: $vm.showEndGameAlert) {
      Button("Cancel", role: .cancel, action: {})
      Button(AlertContext.endGame.buttonTitle, action: { vm.endingGame() })
    } message: {
      Text(AlertContext.endGame.message)
    }
  }
}

//MARK: UI Components
extension GameView {
  private var header: some View {
    VStack(alignment: .center, spacing: 10) {
      Text(vm.currentPlayerOnTurn?.name ?? "Unknown Player")
        .font(.title)
        .bold()

      HStack {
        VStack(alignment: .leading, spacing: 5) {
          Text("gameView.headerLabel.total_score")
            .font(.headline)
            .fontWeight(.semibold)
          Text("\(vm.currentPlayerOnTurn?.currentScore ?? 0)")
            .font(.subheadline)
        }
        .lineLimit(1)
        Spacer()

        VStack(alignment: .trailing, spacing: 5) {
          Text("gameView.headerLabel.this_turn_score")
            .font(.headline)
            .fontWeight(.semibold)
          Text("\(vm.calculatedScore)")
            .font(.subheadline)
            .animation(.none, value: vm.calculatedScore)
        }
        .lineLimit(1)
      }

    }
    .animation(.none, value: vm.currentPlayerOnTurn)
    .padding()
    .frame(maxWidth: .infinity)
    .background(Color.secondaryBackground)
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
    )
  }

  private var center: some View {
    VStack(spacing: 20) {
      scoreSliderStack
      divider
      timesDrawnStack
      divider
      playedCardStack
    }
    .padding()
    .frame(maxWidth: .infinity)
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
    )
    .overlay( circularResetButton.offset(x: 10, y: -15), alignment: .topTrailing )
  }

  private var scoreSliderStack: some View {
    VStack(alignment: .leading) {
      Text("gameView.scoreSlider.label_text")
        .font(.headline)

      HStack(spacing: 20) {
        Text(String(format: "%02d", Int(vm.scoreSliderValue)))
          .monospacedDigit()
          .frame(minWidth: 20)
        Slider(value: $vm.scoreSliderValue, in: 0...15, step: 1)
          .onChange(of: vm.scoreSliderValue) { _ in
            HapticManager.shared.impact(style: .light)
          }
      }
    }
  }

  private var timesDrawnStack: some View {
    VStack(alignment: .leading) {
      Text("gameView.timesDrawnPicker.label_text")
        .font(.headline)
      TimesDrawnPicker(selection: $vm.timesDrawn)
    }
  }

  private var playedCardStack: some View {
    VStack(alignment: .leading) {
      Text("gameView.playedCardPicker.label_text")
        .font(.headline)
      PlayedCardPicker(selection: $vm.playedCard, timesDrawn: $vm.timesDrawn)
    }
  }

  private var divider: some View {
    RoundedRectangle(cornerRadius: 1)
      .fill(Color.tertiaryBackground)
      .frame(height: 2)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 20)
  }

  private var nextPlayerButton: some View {
    Button("gameView.nextPlayerButton.label_text") {
      vm.nextPlayer()
      toggleScaleAnimation()
      HapticManager.shared.notification(type: .success)
    }
    .buttonStyle(.offsetStyle)
  }

  private var exitGameButton: some View {
    Button("gameView.exitGameButton.label_text") {
      if vm.game?.turns?.count != nil {
        vm.showExitGameAlert.toggle()
      } else {
        exitGame()
      }
    }
    .buttonStyle(.offsetStyle)
  }

  private var endGameButton: some View {
    Button("gameView.endGameButton.label_text") {
      vm.showEndGameAlert.toggle()
      HapticManager.shared.notification(type: .success)
    }
    .buttonStyle(.offsetStyle)
    .disabled(vm.game?.turns?.count == 0)
  }

  private var circularResetButton: some View {
    Button("\(Image(systemSymbol: .arrowUturnBackwardCircle))") {
      vm.resetTurnState()
    }
    .buttonStyle(.circularOffsetStyle)
    .offset(x: -10, y: -10)
  }
}

// MARK: - UI Methods
extension GameView {
  private func toggleScaleAnimation() {
    isAnimated = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      isAnimated = false
    }
  }

  func exitGame() {
   appState.homeViewID = UUID()
   HapticManager.shared.notification(type: .success)
 }
}
