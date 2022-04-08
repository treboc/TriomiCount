//
//  GameDetailView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 31.03.22.
//

import SwiftUI

struct GameDetailView: View {
  @Environment(\.dismiss) var dismiss
  let game: Game

  var body: some View {
    VStack {
      HStack {
        Text("Game-ID")
        Spacer()
        Text(game.id.debugDescription)
      }

      Divider()

      HStack {
        Text("Startet on:")
        Spacer()
        Text(game.wrappedStartedOn.formatted(date: .abbreviated, time: .shortened))
      }

      Divider()

      HStack {
        Text("The last player on turn is:")
        Spacer()
        Text(game.playersArray.first?.name ?? "Unknown")
      }

      Divider()

      VStack {
        HStack {
          Text("Name")
          Spacer()
          Text("Score")
        }

        ForEach(game.playersArray) { player in
          HStack {
            Text(player.wrappedName)
            Spacer()
            Text("\(player.getPlayersGameScore(ofGame: game.objectID) ?? 0)")
          }
        }
      }

      Button("Delete") {
        PersistentStore.shared.context.delete(game)
        dismiss()
      }
    }

    Divider()

    HStack {
      if game.hasEnded {
        Text("Game finished.")
      }
    }
  }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
      GameDetailView(game: Game.allGames().first!)
    }
}
