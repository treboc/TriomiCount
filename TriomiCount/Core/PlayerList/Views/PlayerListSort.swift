//
//  PlayerListSort.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 23.02.22.
//

import Foundation
import CoreData

struct PlayerListSort: Hashable, Identifiable {
    let id: Int
    let name: String
    let descriptors: [SortDescriptor<Player>]
    
    static let sorts: [PlayerListSort] = [
        PlayerListSort(
            id: 0,
            name: "Highscore (high to low)",
            descriptors: [
                SortDescriptor(\.highscore_, order: .reverse)
            ]),
        PlayerListSort(
            id: 1,
            name: "Highscore (low to high)",
            descriptors: [
                SortDescriptor(\.highscore_, order: .forward)
            ]),
        PlayerListSort(
            id: 2,
            name: "Name (A…Z)",
            descriptors: [
                SortDescriptor(\.name_, order: .forward)
            ]),
        PlayerListSort(
            id: 3,
            name: "Name (Z…A)",
            descriptors: [
                SortDescriptor(\.name_, order: .reverse),
            ]),
        PlayerListSort(
            id: 2,
            name: "Last created",
            descriptors: [
                SortDescriptor(\.createdOn_, order: .reverse)
            ]),
    ]
    
    static var `default`: PlayerListSort { sorts[0] }
}
