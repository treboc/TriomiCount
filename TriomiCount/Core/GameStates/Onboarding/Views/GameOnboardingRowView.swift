//
//  NewGameChoosePlayerListRowView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 25.01.22.
//

import SwiftUI

struct GameOnboardingRowView: View {
  let player: Player
  let position: Int?

  var body: some View {
    ZStack {
      Color.primaryAccentColor
      HStack {
        ZStack {
          Image(systemName: "circle.dotted")
            .font(.title)
          position != nil ? Text("\(position ?? 0)") : Text("")
        }
        .frame(width: 30, height: 30)

        Text("\(player.name)")
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
      RoundedRectangle(cornerRadius: 15, style: .continuous)
        .strokeBorder(Color.secondaryAccentColor, lineWidth: 2)
    )
    .cornerRadius(20)
    .frame(height: 65)
    .frame(maxWidth: .infinity)
    .listRowSeparator(.hidden)
    .offset(y: player.isChosen ? 0 : -4)
    .background(
      Color.secondaryAccentColor
        .frame(height: 65)
        .cornerRadius(15)
    )
    .padding(.top, 5)
    .accessibilityLabel("Player \(player.name), \(player.isChosen ? "is chosen" : "is not chosen")")
  }
}

//struct NewGameChoosePlayerListRowView_Previews: PreviewProvider {
//  static var previews: some View {
//    GameOnboardingRowView(player: Player(context: PersistentStore.previewGameOnBoardingRowView.context), position: 1)
//      .padding()
//      .environment(\.managedObjectContext, PersistentStore.previewGameOnBoardingRowView.context)
//  }
//}
