//
//  GameListRowView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 05.04.22.
//

import Inject
import SwiftUI

struct GameListRowView: View {
  let game: Game

  var body: some View {
    ZStack(alignment: .topLeading) {
      Color("SecondaryAccentColor")
        .opacity(1)
        .cornerRadius(20)

      HStack(alignment: .top) {
        VStack(alignment: .leading, spacing: 3) {
          Text("\(L10n.GameListRowView.session) #\(game.id)")
            .font(.headline.bold())

          HStack(alignment: .firstTextBaseline) {
            Text(L10n.GameListRowView.playedBy)
              .bold()
            Text(game.playedBy)
              .multilineTextAlignment(.leading)
          }
          .font(.subheadline)
        }

        Spacer()

        Text(game.startedOnAsString)
          .font(.caption)
      }
      .foregroundColor(.white)
      .padding(.horizontal)
      .padding(.vertical, 10)
    }
    .frame(maxWidth: .infinity)
    .listRowSeparator(.hidden)
    .enableInjection()
  }

#if DEBUG
  @ObservedObject private var iO = Inject.observer
#endif
}

struct GameListRowView_Previews: PreviewProvider {
    static var previews: some View {
      GameListRowView(game: Game.allGames().first!)
    }
}
