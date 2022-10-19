//
//  SessionResultsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 28.02.22.
//

import SwiftUI

struct SessionResultsView: View {
  @EnvironmentObject var viewModel: SessionViewModel
  @EnvironmentObject var sessionPresentationManager: SessionPresentationManager

  var body: some View {
    ZStack {
      VStack {
        Text(L10n.SessionResultsView.sessionResults)
          .font(.largeTitle)
          .fontWeight(.semibold)
          .padding(.bottom, 20)

        HStack {
          Text(L10n.SessionResultsView.name)
          Spacer()
          Text(L10n.SessionResultsView.points)
        }
        .font(.title2)

        Divider()

        ForEach(viewModel.session.playersArray.sorted(by: { $0.currentScore > $1.currentScore })) { player in
          HStack {
            Text(player.wrappedName)
            Spacer()
            Text("\(player.currentScore) Pts.")
          }
        }
        .padding([.bottom, .top], 15)

        Spacer()

        Button(L10n.Button.backToMainMenu, action: sessionPresentationManager.hideSession)
          .buttonStyle(.shadowed)
          .padding(.bottom, 50)
      }
      .padding(.horizontal, 30)

      Spacer()
    }
  }
}
