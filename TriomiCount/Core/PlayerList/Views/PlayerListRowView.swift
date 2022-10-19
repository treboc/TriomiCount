//
//  PlayerListRowView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.01.22.
//

import SwiftUI

struct PlayerListRowView: View {
  let player: Player

  var body: some View {
    HStack(alignment: .center) {
      Text(player.wrappedName)
        .font(.headline.bold())

      Spacer()

      VStack(alignment: .center) {
        Text(player.highscore.roundedWithAbbreviations)
        Text("Highscore")
          .font(.caption)
          .foregroundColor(.secondary)
      }
    }
    .frame(maxWidth: .infinity)
    .padding()
    .background(
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .fill(.ultraThinMaterial)
        .shadow(radius: 3)
    )
  }
}
