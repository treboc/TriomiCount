//
//  GameResultsView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 28.02.22.
//

import SwiftUI

struct GameResultsView: View {
  @EnvironmentObject var vm: GameViewModel
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    ZStack {
      VStack {
        Text("Game Results")
          .font(.largeTitle)
          .fontWeight(.semibold)
          .padding(.bottom, 20)

        HStack {
          Text("Name")
            .font(.title2)
          Spacer()
          Text("Points")
        }

        Divider()

        ForEach(vm.game?.playersArray.sorted(by: { $0.currentScore > $1.currentScore }) ?? []) { player in
          HStack {
            Text(player.name)
              .font(.title2)

            Spacer()

            Text("\(player.currentScore) Pts.")
          }
        }
        .padding([.bottom, .top], 15)

        Spacer()

        Button("Main menu") {
          dismiss()
        }
        .buttonStyle(.offsetStyle)
        .padding(.bottom, 50)
      }
      .padding(.horizontal, 30)

      Spacer()
    }
  }
}
