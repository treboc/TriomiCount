//
//  PlayerListSort.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 23.02.22.
//

import Foundation
import CoreData
import SwiftUI

enum PlayerListSort {
  struct PlayerListSortItem: Identifiable, Hashable {
    let id: Int
    let orderLabel: String
    let image: String
    let descriptors: [SortDescriptor<Player>]

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
      hasher.combine(orderLabel)
    }
  }

  case nameAsc, nameDesc, highscoreAsc, highscoreDesc, lastCreated

  var sortItem: PlayerListSortItem {
    switch self {
    case .nameAsc:
      return PlayerListSortItem(
        id: 2,
        orderLabel: L10n.PlayerListSortView.OrderLabel.ascending,
        image: "arrow.up",
        descriptors: [
          SortDescriptor(\.name, order: .forward)
        ])
    case .nameDesc:
      return PlayerListSortItem(
        id: 3,
        orderLabel: L10n.PlayerListSortView.OrderLabel.descending,
        image: "arrow.down",
        descriptors: [
          SortDescriptor(\.name, order: .reverse)
        ])
    case .highscoreAsc:
      return PlayerListSortItem(
        id: 0,
        orderLabel: L10n.PlayerListSortView.OrderLabel.ascending,
        image: "arrow.up",
        descriptors: [
          SortDescriptor(\.highscore, order: .forward)
        ])
    case .highscoreDesc:
      return PlayerListSortItem(
        id: 1,
        orderLabel: L10n.PlayerListSortView.OrderLabel.descending,
        image: "arrow.down",
        descriptors: [
          SortDescriptor(\.highscore, order: .reverse)
        ])
    case .lastCreated:
      return PlayerListSortItem(
        id: 2,
        orderLabel: L10n.PlayerListSortView.OrderLabel.lastCreated,
        image: "arrow.down",
        descriptors: [
          SortDescriptor(\.createdOn, order: .reverse)
        ])
    }
  }
}
