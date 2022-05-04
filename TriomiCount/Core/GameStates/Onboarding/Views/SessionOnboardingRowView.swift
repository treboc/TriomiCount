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
  let height: CGFloat = UIScreen.main.bounds.height / 16

  var body: some View {
    ZStack {
      Color.primaryAccentColor
      HStack {
        ZStack {
          Image(systemName: "circle.dotted")
            .font(.title)
          position != nil ? Text("\(position ?? 0)") : Text("")
        }
        .frame(width: 25, height: 25)

        Text("\(player.wrappedName)")
        Spacer()
        VStack(alignment: .center) {
          Text("\(player.highscore)")
          Text("Highscore")
            .font(.caption)
        }
      }
      .foregroundColor(.white)
      .padding(.horizontal)

    }
    .overlay(
      RoundedRectangle(cornerRadius: 20, style: .continuous)
        .strokeBorder(Color.secondaryAccentColor, lineWidth: 2)
    )
    .cornerRadius(20)
    .frame(height: height)
    .frame(maxWidth: .infinity)
    .listRowSeparator(.hidden)
    .offset(y: player.isChosen ? 0 : -4)
    .background(
      Color.secondaryAccentColor
        .frame(height: height)
        .cornerRadius(20)
    )
    .padding(.top, 5)
    .accessibilityLabel("Player \(player.wrappedName), \(player.isChosen ? "is chosen" : "is not chosen")")
  }
}
