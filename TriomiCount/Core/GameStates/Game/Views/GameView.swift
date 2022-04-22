//
//  GameView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 19.03.22.
//

import Inject
import SwiftUI

struct GameView: View {
  @StateObject var viewModel: GameViewModel
  @EnvironmentObject var appState: AppState
  @State private var isAnimated: Bool = false

  var body: some View {
    ZStack {
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
      .onAppear(perform: viewModel.resetTurnState)
      .tint(.primaryAccentColor)
      .padding()
      .alert(AlertContext.exitGame.title, isPresented: $viewModel.showExitGameAlert) {
        Button("Cancel", role: .cancel) {}
        Button(action: { exitGame() },
               label: { Text("exitGameAlert.buttonTitle") }
        )
      } message: {
        Text(AlertContext.exitGame.message)
      }
      .confirmationDialog(AlertContext.endGame.title, isPresented: $viewModel.showEndGameAlert, titleVisibility: .visible) {
        Button(action: { viewModel.endingGame() },
               label: { Text("endGameAlert.messageWithWinner \(viewModel.currentPlayerOnTurn!.wrappedName)") }
        )
        Button("endGameAlert.messageTie") {
          viewModel.endingGame()
        }
      }
      .blur(radius: viewModel.bonusEventPickerOverlayIsShown ? 5 : 0)
      .allowsHitTesting(viewModel.bonusEventPickerOverlayIsShown ? false : true)

      if viewModel.bonusEventPickerOverlayIsShown {
        BonusEventPicker.SelectionOverlay(viewModel: viewModel)
      }
    }
    .enableInjection()
  }

  #if DEBUG
  @ObservedObject private var iO = Inject.observer
  #endif
}

// MARK: UI Components
extension GameView {
  private var header: some View {
    VStack(alignment: .center, spacing: 10) {
      Text(viewModel.currentPlayerOnTurn?.name ?? "Unknown Player")
        .font(.title)
        .bold()

      HStack {
        VStack(alignment: .leading, spacing: 5) {
          Text("gameView.headerLabel.total_score")
            .font(.headline)
            .fontWeight(.semibold)
          Text("\(viewModel.currentPlayerOnTurn?.currentScore ?? 0)")
            .font(.subheadline)
        }
        .lineLimit(1)

        Spacer()

        VStack(alignment: .trailing, spacing: 5) {
          Text("gameView.headerLabel.this_turn_score")
            .font(.headline)
            .fontWeight(.semibold)
          Text("\(viewModel.calculatedScore)")
            .font(.subheadline)
            .animation(.none, value: viewModel.calculatedScore)
        }
        .lineLimit(1)
      }
    }
    .animation(.none, value: viewModel.currentPlayerOnTurn)
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
    VStack(spacing: 10) {
      scoreSliderStack
      divider
      timesDrawnStack
      divider
      playedCardStack
      divider
      bonusEventStack
    }
    .padding()
    .frame(maxWidth: .infinity)
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
    )
    .overlay( circularResetButton.offset(x: 10, y: -15).scaleEffect(0.8), alignment: .topTrailing )
  }

  private var scoreSliderStack: some View {
    VStack(alignment: .leading) {
      Text("gameView.scoreSlider.label_text")
        .font(.headline)

      HStack(spacing: 20) {
        Text(String(format: "%02d", Int(viewModel.scoreSliderValue)))
          .monospacedDigit()
          .frame(minWidth: 20)
        Slider(value: $viewModel.scoreSliderValue, in: 0...15, step: 1)
          .onChange(of: viewModel.scoreSliderValue) { _ in
            HapticManager.shared.impact(style: .light)
          }
          .tint(.primaryAccentColor)
      }
      .padding(.horizontal)
    }
  }

  private var timesDrawnStack: some View {
    VStack(alignment: .leading) {
      Text("gameView.timesDrawnPicker.label_text")
        .font(.headline)
      TimesDrawnPicker(selection: $viewModel.timesDrawn)
        .padding(.horizontal)
    }
  }

  private var playedCardStack: some View {
    VStack(alignment: .leading) {
      Text("gameView.playedCardPicker.label_text")
        .font(.headline)
      PlayedCardPicker(selection: $viewModel.playedCard, timesDrawn: $viewModel.timesDrawn)
        .padding(.horizontal)
    }
  }

  private var bonusEventStack: some View {
    VStack(alignment: .leading) {
      Text("gameView.bonusEventPicker.label_text")
        .font(.headline)
      BonusEventPicker(viewModel: viewModel)
        .padding(.horizontal)
    }
  }

  private var divider: some View {
    RoundedRectangle(cornerRadius: 1)
      .fill(Color.tertiaryBackground)
      .frame(height: 2)
      .frame(maxWidth: .infinity)
      .padding(.horizontal, 0)
  }

  private var nextPlayerButton: some View {
    Button("gameView.nextPlayerButton.label_text") {
      viewModel.nextPlayer()
      toggleScaleAnimation()
      HapticManager.shared.notification(type: .success)
    }
    .buttonStyle(.offsetStyle)
  }

  private var exitGameButton: some View {
    Button("gameView.exitGameButton.label_text") {
      if viewModel.game?.turns?.count != nil {
        viewModel.showExitGameAlert.toggle()
      } else {
        exitGame()
      }
    }
    .buttonStyle(.offsetStyle)
  }

  private var endGameButton: some View {
    Button("gameView.endGameButton.label_text") {
      viewModel.showEndGameAlert.toggle()
      HapticManager.shared.notification(type: .success)
    }
    .buttonStyle(.offsetStyle)
    .disabled(viewModel.game?.turns?.count == 0)
  }

  private var circularResetButton: some View {
    Button("\(Image(systemSymbol: .arrowUturnBackwardCircle))") {
      viewModel.resetTurnState()
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
