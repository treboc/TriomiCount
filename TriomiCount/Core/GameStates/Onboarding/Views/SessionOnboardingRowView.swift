//
//  SessionOnboardingRowView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI

struct SessionOnboardingRowView: View {
  let player: Player
  let position: Int?

  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .fill(player.isChosen ? Color.primaryAccentColor.opacity(0.8) : Color.primaryAccentColor)
        .frame(height: Constants.buttonHeight)
        .frame(maxWidth: .infinity)
        .shadow(color: .black.opacity(0.5), radius: 3, x: 0, y: 3)

      HStack {
        ZStack {
          Image(systemName: "circle.dotted")
            .font(.title)
          position != nil ? Text("\(position ?? 0)") : Text("")
        }
        .monospacedDigit()
        .frame(width: 25, height: 25)

        Text("\(player.wrappedName)")
        Spacer()
        VStack(alignment: .center) {
          Text("\(player.highscore)")
          Text("Highscore")
            .font(.caption)
        }
      }
      .padding(.horizontal)
      .foregroundColor(.white)
    }
    .listRowSeparator(.hidden)
    .animation(.none, value: position)
    .accessibilityLabel("Player \(player.wrappedName), \(player.isChosen ? "is chosen" : "is not chosen")")
  }
}
