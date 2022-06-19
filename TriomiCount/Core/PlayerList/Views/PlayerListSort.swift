//
//  PlayerListSort.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 23.02.22.
//

import Foundation
import CoreData
import SwiftUI

struct PlayerListSort: Hashable, Identifiable {
  let id: Int
  let name: String
  let image: Image
  let descriptors: [SortDescriptor<Player>]

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
    hasher.combine(name)
  }

  static let sorts: [PlayerListSort] = [
    PlayerListSort(
      id: 0,
      name: "Highscore",
      image: Image(systemSymbol: .arrowDown),
      descriptors: [
        SortDescriptor(\.highscore, order: .reverse)
      ]),
    PlayerListSort(
      id: 1,
      name: "Highscore",
      image: Image(systemSymbol: .arrowUp),
      descriptors: [
        SortDescriptor(\.highscore, order: .forward)
      ]),
    PlayerListSort(
      id: 2,
      name: "Name",
      image: Image(systemSymbol: .arrowDown),
      descriptors: [
        SortDescriptor(\.name, order: .forward)
      ]),
    PlayerListSort(
      id: 3,
      name: "Name",
      image: Image(systemSymbol: .arrowUp),
      descriptors: [
        SortDescriptor(\.name, order: .reverse)
      ]),
    PlayerListSort(
      id: 2,
      name: "Last created",
      image: Image(systemSymbol: .arrowDown),
      descriptors: [
        SortDescriptor(\.createdOn, order: .reverse)
      ])
  ]

  static var `default`: PlayerListSort { sorts[0] }
}
