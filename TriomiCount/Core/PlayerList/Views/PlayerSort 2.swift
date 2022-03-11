//
//  PlayerSort.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 23.02.22.
//

import Foundation
import CoreData

struct PlayerSort: Hashable, Identifiable {
    let id: Int
    let name: String
    let descriptors: [SortDescriptor<Player>]
    
    static let sorts: [PlayerSort] = [
        PlayerSort(
            id: 0,
            name: "Highscore (high to low)",
            descriptors: [
                SortDescriptor(\.highscore_, order: .reverse)
            ]),
        PlayerSort(
            id: 1,
            name: "Highscore (low to high)",
            descriptors: [
                SortDescriptor(\.highscore_, order: .forward)
            ]),
        PlayerSort(
            id: 2,
            name: "Name (A…Z)",
            descriptors: [
                SortDescriptor(\.name_, order: .forward)
            ]),
        PlayerSort(
            id: 3,
            name: "Name (Z…A)",
            descriptors: [
                SortDescriptor(\.name_, order: .reverse),
            ]),
        PlayerSort(
            id: 2,
            name: "Last created",
            descriptors: [
                SortDescriptor(\.createdOn_, order: .reverse)
            ]),
    ]
    
    static var `default`: PlayerSort { sorts[0] }
}
