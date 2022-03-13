//
//  GameView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI
import SFSafeSymbols

struct GameView: View {
  @StateObject var vm: GameViewModel
  @Environment(\.dismiss) private var dismiss

  private var showPlayedCardView: Bool {
    return vm.timesDrawn == 3
  }

  // ENDGAMEVIEW PROPERTIES
  @State private var endPointsTextFieldText: String = ""
  @State private var isAnimated: Bool = false

  //MARK: Body
  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()
      
      switch vm.gameState {
      case .playing:
        VStack(spacing: 20) {
          headerLabel

          Spacer(minLength: 0)

          centerView

          Spacer()

          VStack {
            nextPlayerButton
            HStack {
              exitGameButton
              endGameButton
            }
          }
        }
        .padding(.vertical, 10)
        .scaleEffect(isAnimated ? 1.05 : 1.0)
        .animation(.default, value: isAnimated)
        .onAppear(perform: vm.resetTurnState)
        .tint(.primaryAccentColor)
        .padding()
      case .isEnding:
        SubmitPointsAfterGameView()
          .environmentObject(vm)
      case .ended:
        GameResultsView()
          .environmentObject(vm)
      case .exited:
        Text("Game was exited.")
      }
    }
    .navigationBarHidden(true)
    .navigationBarBackButtonHidden(true)
    .alert(AlertContext.exitGame.title, isPresented: $vm.showExitGameAlert) {
      Button("Cancel", role: .cancel) {}
      Button(AlertContext.exitGame.buttonTitle) { exitGame() }
    } message: {
      Text(AlertContext.exitGame.message)
    }
    .alert(AlertContext.endGame.title, isPresented: $vm.showEndGameAlert) {
      Button("Cancel", role: .cancel, action: {})
      Button(AlertContext.endGame.buttonTitle, action: { vm.endingGame() })
    }
    
  }
}

struct PlayerView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(vm: GameViewModel(Player.allPlayers()))
      .environment(\.managedObjectContext, PersistentStore.preview.context)
  }
}

//MARK: UI Components
extension GameView {
  private var headerLabel: some View {
    VStack(alignment: .center, spacing: 10) {
      Text(vm.currentPlayerOnTurn?.name ?? "No current player.")
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



  private var centerView: some View {
    VStack(spacing: 20) {
      scoreSliderView
      divider
      timesDrawnPickerView
      divider
      playedCardPicker
    }
    .padding(.top, 20)
    .padding()
    .frame(maxWidth: .infinity)
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .strokeBorder(Color.tertiaryBackground, lineWidth: 2)
    )
    .overlay( circularResetButton, alignment: .topTrailing )
  }

  private var scoreSliderView: some View {
    VStack(alignment: .leading, spacing: 30) {
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

  private var timesDrawnPickerView: some View {
    VStack(alignment: .leading, spacing: 30) {
      Text("gameView.timesDrawnPicker.label_text")
        .font(.headline)
      CardsDrawnPicker(selection: $vm.timesDrawn)
    }
  }

  private var playedCardPicker: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("gameView.playedCardPicker.label_text")
        .font(.headline)
      PlayedCardPicker(selection: $vm.playedCard)
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
      if vm.game.turns?.count != nil {
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
    .disabled(vm.game.turns?.count == 0)
  }

  //  private func offsetStyledButton(_ text: String) -> some View {
  //
  //  }

  private var circularResetButton: some View {
    Button("\(Image(systemSymbol: .arrowUturnBackwardCircle))") {
      vm.resetTurnState()
    }
    .buttonStyle(.circularOffsetStyle)
    .offset(x: -10, y: -10)
  }
}


//MARK: - UI Methods
extension GameView {
  private func exitGame() {
    dismiss()
    HapticManager.shared.notification(type: .success)
  }

  private func toggleScaleAnimation() {
    isAnimated = true
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      isAnimated = false
    }
  }
}
