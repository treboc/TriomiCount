//
//  GameView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI

struct GameView: View {
  @StateObject var vm: GameViewModel
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject var appState: AppState
  
  private var showTimesDrawnView: Bool {
    return vm.drawn
  }
  
  private var showPlayedCardView: Bool {
    return vm.timesDrawn == 3 && vm.drawn
  }
  
  // ALERT - Exit Game

  // ENDGAMEVIEW PROPERTIES
  @State private var endPointsTextFieldText: String = ""
  
  @State private var isAnimated: Bool = false
  
  //MARK: Body
  var body: some View {
    ZStack {
      Color("SecondaryBackground")
        .ignoresSafeArea()
      
      switch vm.gameState {
      case .playing:
        VStack(spacing: 10) {
          headerLabel
          
          scoreSlider
          
          optionsView
          
          Spacer()
          
          nextPlayerButton
          
          HStack {
            exitGameButton
            endGameButton
          }
        }
        .scaleEffect(isAnimated ? 1.05 : 1.0)
        .animation(.spring(), value: isAnimated)
        .onChange(of: vm.currentPlayerOnTurn, perform: { _ in
          animateView()
        })
        .onAppear(perform: resetUIState)
        .tint(.accentColor)
        .padding()
      case .isEnding:
        SubmitPointsAfterGameView()
          .environmentObject(vm)
          .environmentObject(appState)
      case .ended:
        GameResultsView()
          .environmentObject(vm)
          .environmentObject(appState)
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
        VStack(spacing: 5) {
          Text("gameView.headerLabel.total_score")
            .font(.headline)
            .fontWeight(.semibold)
          Text("\(vm.currentPlayerOnTurn?.currentScore ?? 0)")
            .font(.subheadline)
        }
        .lineLimit(1)
        Spacer()
        
        VStack(spacing: 5) {
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
    .padding()
    .frame(maxWidth: .infinity)
    .background(Color(UIColor.quaternaryLabel))
    .cornerRadius(10)
    .padding(.bottom, 20)
  }
  
  private var scoreSlider: some View {
    VStack(alignment: .center, spacing: 10) {
      Text("gameView.scoreSlider.label_text")
      HStack(spacing: 20) {
        Text(String(format: "%02d", Int(vm.scoreSliderValue)))
          .monospacedDigit()
          .frame(minWidth: 20)
        Slider(value: $vm.scoreSliderValue, in: 0...15, step: 1)
      }
    }
    .padding()
    .frame(height: UIScreen.main.bounds.height * 0.25)
    .frame(maxWidth: .infinity)
    .background(Color(UIColor.quaternaryLabel))
    .cornerRadius(10)
  }
  
  private var drawnToggle: some View {
    VStack(spacing: 30) {
      Text("gameView.drawnToggle.label_text")
      Button {
        vm.drawn = true
      } label: {
        Text("Yes")
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.accentColor)
          .foregroundColor(Color.white)
          .cornerRadius(10)
      }
    }
  }
  
  private var timesDrawnPicker: some View {
    VStack(spacing: 20) {
      Text("gameView.timesDrawnPicker.label_text")
        .multilineTextAlignment(.center)
        .frame(height: 55)
      Picker("How many times did you draw?", selection: $vm.timesDrawn.animation(.default)) {
        Text("1").tag(1)
        Text("2").tag(2)
        Text("3").tag(3)
      }
      .pickerStyle(.segmented)
    }
    .padding()
    .frame(maxWidth: .infinity)
    .cornerRadius(10)
  }
  
  private var playedCardPicker: some View {
    VStack(spacing: 20) {
      Text("gameView.playedCardPicker.label_text")
        .multilineTextAlignment(.center)
        .frame(height: 55)
      Picker("Were you able to play the card?", selection: $vm.playedCard.animation(.default)) {
        Text("Yes").tag(true)
        Text("No").tag(false)
      }
      .pickerStyle(.segmented)
    }
    .padding()
    .frame(maxWidth: .infinity)
    .cornerRadius(10)
  }
  
  private var nextPlayerButton: some View {
    Button {
      vm.nextPlayer()
      resetUIState()
      HapticManager.shared.notification(type: .success)
    } label: {
      Text("gameView.nextPlayerButton.label_text")
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.accentColor)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
  }
  
  private var exitGameButton: some View {
    Button {
      if vm.game.turns?.count != nil {
        vm.showExitGameAlert.toggle()
      } else {
        exitGame()
      }
    } label: {
      Text("gameView.exitGameButton.label_text")
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.accentColor)
        .foregroundColor(.white)
        .cornerRadius(10)
    }
  }
  
  private var endGameButton: some View {
    Button {
      //TODO: - Add function to end the game!
      vm.showEndGameAlert.toggle()
      HapticManager.shared.notification(type: .success)
    } label: {
      Text("gameView.endGameButton.label_text")
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.accentColor)
        .foregroundColor(Color.white)
        .cornerRadius(10)
    }
    .disabled(vm.game.turns?.count == 0)
  }
  
  private var optionsView: some View {
    VStack {
      if !vm.drawn && vm.timesDrawn != 3 {
        drawnToggle
      } else if vm.drawn && vm.timesDrawn != 3 {
        timesDrawnPicker
        Spacer()
        resetUIButton
      } else if vm.drawn && vm.timesDrawn == 3 {
        playedCardPicker
        Spacer()
        resetUIButton
      } else {
        drawnToggle.hidden()
      }
    }
    .padding()
    .frame(height: UIScreen.main.bounds.height * 0.25)
    .frame(maxWidth: .infinity)
    .background(Color(UIColor.quaternaryLabel))
    .cornerRadius(10)
  }
  
  private var resetUIButton: some View {
    Button {
      resetToggles()
    } label: {
      Text("Reset")
    }
    
  }
  
}


//MARK: - UI Methods
extension GameView {
  private func resetUIState() {
    vm.scoreSliderValue = 0
    vm.drawn = false
    vm.timesDrawn = 1
    vm.playedCard = false
  }
  
  private func resetToggles() {
    vm.drawn = false
    vm.timesDrawn = 1
    vm.playedCard = false
  }
  
  private func exitGame() {
    appState.gameOnboardingIsShown.toggle()
    if appState.gameOnboardingIsShown == false {
      self.dismiss()
    }
    
    HapticManager.shared.notification(type: .success)
  }
  
  private func animateView() {
    withAnimation {
      HapticManager.shared.notification(type: .success)
      isAnimated = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        isAnimated = false
      }
    }
  }
}
