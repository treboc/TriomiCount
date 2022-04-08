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
    ZStack {
      Color("SecondaryAccentColor").opacity(0.5).cornerRadius(10)

      HStack {
        Text("\(game.id)")
      }
      .foregroundColor(.white)
      .padding(.horizontal)
    }
    .frame(height: 65)
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
