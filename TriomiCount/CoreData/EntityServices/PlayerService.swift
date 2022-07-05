//
//  PlayerService.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 04.07.22.
//

import Foundation
import CoreData
import UIKit

enum NameError: Error {
  case isEmptyString, tooLong

  var message: String {
    switch self {
    case .isEmptyString:
      return L10n.AddNewPlayerView.AlertTextFieldEmpty.message
    case .tooLong:
      return L10n.AddNewPlayerView.AlertNameToLong.message
    }
  }
}

public class PlayerService: EntityServiceBase {
  static func addNewPlayer(_ name: String,
                           favoriteColor: UIColor = .clear,
                           in context: NSManagedObjectContext = CoreDataManager.shared.context) {
    let player = Player(context: context)
    player.id = UUID()
    player.name = name
    player.favoriteColor = favoriteColor

    CoreDataManager.shared.save()
  }

  static func toggleChosenState(_ player: Player) {
    player.isChosen.toggle()
    CoreDataManager.shared.save()
  }
}
