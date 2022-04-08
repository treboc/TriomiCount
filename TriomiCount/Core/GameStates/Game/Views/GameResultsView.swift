//
//  GameResultsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 28.02.22.
//

import SwiftUI

struct GameResultsView: View {
  @EnvironmentObject var viewModel: GameViewModel
  @EnvironmentObject var appState: AppState

  var body: some View {
    ZStack {
      VStack {
        Text("Game Results")
          .font(.largeTitle)
          .fontWeight(.semibold)
          .padding(.bottom, 20)

        HStack {
          Text("Name")
            .font(.title2)
          Spacer()
          Text("Points")
        }

        Divider()

        ForEach(viewModel.game?.playersArray.sorted(by: { $0.currentScore > $1.currentScore }) ?? []) { player in
          HStack {
            Text(player.wrappedName)
              .font(.title2)

            Spacer()

            Text("\(player.currentScore) Pts.")
          }
        }
        .padding([.bottom, .top], 15)

        Spacer()

        Button("Main menu") {
          appState.onboardingScreen = UUID()
        }
        .buttonStyle(.offsetStyle)
        .padding(.bottom, 50)
      }
      .padding(.horizontal, 30)

      Spacer()
    }
  }
}
