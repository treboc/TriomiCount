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
    session.id = UUID()
    session.startedOn = Date()
    session.turns = NSSet()

    players.forEach {
      $0.currentScore = 0
      $0.isChosen = false
    }

    session.addToPlayers(NSSet(array: players))
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

struct PersistedSession: Codable, Identifiable {
  struct PersistedTurn: Codable {
    let name: String
    let points: Int
  }

  let id: UUID
  let sessionCount: Int
  let startedOn: Date
  let endedOn: Date
  let winner: String
  let turns: [PersistedTurn]
  let players: [String]
}

struct PersistedSessionService {
  static let fileURL: URL = .documentsDirectory.appending(path: "sessions.json")

  static func convertSession(_ session: Session) -> PersistedSession {
    var persistedTurns: [PersistedSession.PersistedTurn] = []
    session.turnsArray.forEach { turn in
      if let id = turn.playerID,
         let player = Player.object(id: id, context: CoreDataManager.shared.context) {
        let pTurn = PersistedSession.PersistedTurn(name: player.wrappedName,
                                                   points: Int(turn.playersScoreInTurn))
        persistedTurns.append(pTurn)
      }
    }

    let persistedSession: PersistedSession = .init(
      id: session.id,
      sessionCount: Int(session.sessionCounter),
      startedOn: session.wrappedStartedOn,
      endedOn: session.wrappedEndedOn,
      winner: session.winner ?? "No Winner",
      turns: persistedTurns,
      players: session.playersArray.map(\.wrappedName))
    return persistedSession
  }

  static func saveSession(_ session: Session) {
    var allSessions = Self.loadSessions()
    let persistedSession = Self.convertSession(session)
    allSessions.append(persistedSession)

    do {
      let data = try JSONEncoder().encode(allSessions)
      try data.write(to: Self.fileURL, options: .atomic)
    } catch {
      print(error.localizedDescription)
    }
  }

  static func loadSessions() -> [PersistedSession] {
    var sessions: [PersistedSession] = []

    do {
      let data = try Data(contentsOf: Self.fileURL)
      sessions = try JSONDecoder().decode([PersistedSession].self, from: data)
    } catch {
      print(error.localizedDescription)
    }

    return sessions
  }
}
