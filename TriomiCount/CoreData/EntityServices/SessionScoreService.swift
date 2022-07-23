//
//  SessionScoreService.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 23.07.22.
//

import Foundation

public class SessionScoreService: EntityServiceBase {
  // 1. Get all SessionScore corrosponding to the current session entity
  // 2. get all names of the current players
  // 3. return dict [playerName: String,
  //                 score: Int16]
  static func getScores(of session: Session) -> [String: Int16] {
    var dict = [String: Int16]()
    session.playersArray.forEach {
      guard let score = $0.gameScoreDictsArray.filter({ $0.sessionID == session.id }).first?.scoreValue else { return }
      dict[$0.wrappedName] = score
    }

    return dict
  }

}
