//
//  GamesListView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.03.22.
//

import SwiftUI
import CoreData

struct GamesListView: View {
  @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Game.hasEnded_, ascending: true)], animation: .default) private var games: FetchedResults<Game>
  
  var body: some View {
    List {
      ForEach(games) { game in
        VStack {
          CustomNavLink(title: LocalizedStringKey("Game, startet on \(game.startedOn)"), destination: GameDetailView(game: game))
        }
      }
    }
  }
}

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
        Text(game.startedOn.formatted(date: .abbreviated, time: .shortened))
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
            Text(player.name)
            Spacer()
            Text("\(player.getPlayersGameScore(ofGame: game.id) ?? 0)")
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




struct GamesListView_Previews: PreviewProvider {
  static var previews: some View {
    GamesListView()
  }
}
