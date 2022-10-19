//
//  PlayerListSortView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.02.22.
//

import SwiftUI
import SFSafeSymbols

struct PlayerListSortView: View {
  @Binding var selectedSortItem: PlayerListSort

  var body: some View {
    Menu {
      Menu("Name") {
        ForEach([PlayerListSort.nameAsc,
                 PlayerListSort.nameDesc], id: \.hashValue) { sort in
            Button {
              selectedSortItem = sort
            } label: {
              Label(sort.sortItem.orderLabel, systemImage: sort.sortItem.image)
            }
          }
      }

      Menu("Highscore") {
        ForEach([PlayerListSort.highscoreAsc,
                 PlayerListSort.highscoreDesc], id: \.hashValue) { sort in
          Button {
            selectedSortItem = sort
          } label: {
            Label(sort.sortItem.orderLabel, systemImage: sort.sortItem.image)
          }
        }
      }

      Button {
        selectedSortItem = .lastCreated
      } label: {
        Label(PlayerListSort.lastCreated.sortItem.orderLabel,
              systemImage: PlayerListSort.lastCreated.sortItem.image)
      }
    } label: {
      Label(
        "Sort",
        systemSymbol: .arrowUpArrowDown)
      .font(.system(.body, design: .rounded).bold())
      .foregroundColor(.accentColor)
    }
  }
}
