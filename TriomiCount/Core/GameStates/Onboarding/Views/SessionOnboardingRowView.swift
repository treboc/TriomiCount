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
        .fill(.black.opacity(0.1))
        .frame(height: Constants.buttonHeight)
        .shadow(color: .black.opacity(1), radius: player.isChosen ? 0 : 3, x: 0, y: 0)
        .animation(.easeIn(duration: 0.1), value: player.isChosen)
        .offset(y: 4)

      label
    }
    .listRowSeparator(.hidden)
    .animation(.none, value: position)
    .accessibilityLabel("Player \(player.wrappedName), \(player.isChosen ? "is chosen" : "is not chosen")")
  }

  private var label: some View {
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
    .background(
      RoundedRectangle(cornerRadius: Constants.cornerRadius)
        .fill(player.isChosen ? Color.primaryAccentColor.opacity(0.8) : Color.primaryAccentColor)
        .frame(height: Constants.buttonHeight)
        .frame(maxWidth: .infinity)
    )
//    .offset(y: player.isChosen ? 4 : 0)
  }
}
