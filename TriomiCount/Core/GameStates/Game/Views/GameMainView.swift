//
//  GameMainView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 22.01.22.
//

import SwiftUI
import SFSafeSymbols

struct GameMainView: View {
  @StateObject var viewModel: GameViewModel
  @EnvironmentObject var appState: AppState

  // MARK: Body
  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      switch viewModel.gameState {
      case .playing:
        GameView(viewModel: viewModel)
      case .isEnding:
        ZStack {
          GameView(viewModel: viewModel)
            .blur(radius: 10)
            .allowsHitTesting(false)
          PointsSubmitView()
            .environmentObject(viewModel)
        }
      case .ended:
        GameResultsView()
          .environmentObject(viewModel)
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
    GameMainView(viewModel: GameViewModel(Player.allPlayers()))
      .environment(\.managedObjectContext, PersistentStore.preview.context)
  }
}
