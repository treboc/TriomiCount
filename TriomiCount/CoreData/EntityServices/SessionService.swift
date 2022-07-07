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
    session.playerNamesHash = getHash(of: session.playersArray)

    return session
  }

  static func getHash(of players: [Player]) -> Int64 {
    var hasher = Hasher()
    for player in players {
      hasher.combine(player.wrappedName)
    }
    print(hasher.finalize())
    return Int64(hasher.finalize())

  }

  static func getLastNotFinishedSession(in context: NSManagedObjectContext = CoreDataManager.shared.context) -> Session? {
    let predicate = NSPredicate(format: "hasEnded = false")
    let fetchRequest: NSFetchRequest<Session> = NSFetchRequest<Session>(entityName: Session.description())
    fetchRequest.predicate = predicate
    do {
      let result = try context.fetch(fetchRequest)
      guard let lastSession = result.last else { return nil }

      // deleting all older, not finished sessions, but the last
      for session in result {
        if (session != lastSession) && (!session.hasEnded) {
          EntityServiceBase.deleteObject(session, in: context)
        }
      }

      if getHash(of: lastSession.playersArray) != lastSession.playerNamesHash {
        EntityServiceBase.deleteObject(lastSession, in: context)
      } else {
        return lastSession
      }
    } catch let error as NSError {
      print("Could not find any session that has not ended. Error: \(error.localizedDescription)")
    }
    return nil
  }

}
