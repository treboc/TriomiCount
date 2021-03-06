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
    ZStack {
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .fill(Color.primaryAccentColor)
        .shadow(radius: 3)

      HStack {
        Text("\(player.wrappedName)")
          .fontWeight(.medium)
        Spacer()
        VStack(alignment: .center) {
          Text(player.highscore.roundedWithAbbreviations)
          Text("Highscore")
            .font(.caption)
        }
      }
      .foregroundColor(.white)
      .padding(.horizontal)
    }
    .frame(maxWidth: .infinity)
    .listRowSeparator(.hidden)
  }
}
