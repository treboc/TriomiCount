//
//  SessionResultsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 28.02.22.
//

import SwiftUI

struct SessionResultsView: View {
  @EnvironmentObject var viewModel: SessionViewModel
  @EnvironmentObject var appState: AppState

  var body: some View {
    ZStack {
      VStack {
        Text(L10n.SessionResultsView.sessionResults)
          .font(.largeTitle)
          .fontWeight(.semibold)
          .padding(.bottom, 20)

        HStack {
          Text(L10n.SessionResultsView.name)
            .font(.title2)
          Spacer()
          Text(L10n.SessionResultsView.points)
        }

        Divider()

        ForEach(viewModel.session.playersArray.sorted(by: { $0.currentScore > $1.currentScore })) { player in
          HStack {
            Text(player.wrappedName)
              .font(.title2)

            Spacer()

            Text("\(player.currentScore) Pts.")
          }
        }
        .padding([.bottom, .top], 15)

        Spacer()

        Button(L10n.backToMainMenu) {
          appState.homeViewID = UUID()
        }
        .buttonStyle(.offsetStyle)
        .padding(.bottom, 50)
      }
      .padding(.horizontal, 30)

      Spacer()
    }
  }
}
