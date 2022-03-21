//
//  GameMainView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI
import SFSafeSymbols

struct GameMainView: View {
  @StateObject var vm: GameViewModel
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject var appState: AppState

  //MARK: Body
  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()
      
      switch vm.gameState {
      case .playing:
        GameView(vm: vm)
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

  }
}

struct PlayerView_Previews: PreviewProvider {
  static var previews: some View {
    GameMainView(vm: GameViewModel(Player.allPlayers()))
      .environment(\.managedObjectContext, PersistentStore.preview.context)
  }
}

extension GameMainView {
  func exitGame() {
   appState.homeViewID = UUID()
   HapticManager.shared.notification(type: .success)
  }
}
