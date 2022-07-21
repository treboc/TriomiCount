//
//  SessionService.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 07.07.22.
//

import CoreData

public class SessionService: EntityServiceBase {
  static func addSession(with players: [Player], in context: NSManagedObjectContext = CoreDataManager.shared.context) -> Session {
    let session = Session(context: context)

    for player in players {
      player.currentScore = 0
      player.isChosen = false
    }

    session.addToPlayers(NSSet(array: players))
    session.turns = NSSet()
    session.startedOn = .now
    session.playerNamesHash = Int64(session.playersArray.hashValue)

    return session
  }

  static func getHash(of players: [Player]) -> Int64 {
    var hasher = Hasher()
    for player in players {
      hasher.combine(player.wrappedName)
    }
    return Int64(hasher.finalize())
  }

  static func getLastNotFinishedSession(in context: NSManagedObjectContext = CoreDataManager.shared.context) -> Session? {
    let result = EntityServiceBase.allObjects(Session.self, in: context)
      .filter { !$0.hasEnded }
      .sorted { $0.wrappedStartedOn < $1.wrappedStartedOn }
    // deleting all older, not finished sessions, but the last
    for session in result {
      if session != result.last {
        EntityServiceBase.deleteObject(session, in: context)
      } else {
        return session
      }
    }
    return nil
  }
}
