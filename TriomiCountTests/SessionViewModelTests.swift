//
//  SessionViewModelTests.swift
//  TriomiCountTests
//
//  Created by Marvin Lee Kobert on 04.07.22.
//

import XCTest
@testable import TriomiCount
import SwiftUI

class SessionOnboardingViewModelTests: XCTestCase {
  var coreDataManager: CoreDataManager!
  var sut: SessionOnboardingViewModel!

  override func setUpWithError() throws {
    coreDataManager = CoreDataManager(.inMemory)
    sut = SessionOnboardingViewModel()
  }

  override func tearDownWithError() throws {
    coreDataManager = nil
    sut = nil
  }

  func test_toggleChosenState_shouldAddPlayerToChosenPlayers() {
    PlayerService.addNewPlayer("Dummy", in: coreDataManager.context)
    let player = PlayerService.allObjects(Player.self, in: coreDataManager.context).first!

    sut.choose(player)

    let expected = sut.chosenPlayers.contains(player)

    XCTAssertTrue(expected)
  }

  func test_toggleChosenState_ifOnePlayerIsChosen_PositionShouldBeOne() {
    PlayerService.addNewPlayer("Dummy", in: coreDataManager.context)
    let player = PlayerService.allObjects(Player.self, in: coreDataManager.context).first!

    sut.choose(player)

    let expected: Int16 = 1
    XCTAssertEqual(expected, player.position)
  }

  func test_choose_if5PlayersAreChosen_positionShouldMatch() {
    // Create 5 players to test on
    for index in 0..<5 {
      PlayerService.addNewPlayer("Dummy \(index)", in: coreDataManager.context)
    }

    let players = PlayerService.allObjects(Player.self, in: coreDataManager.context)

    // Add them all to the chosenPlayersArray and give them a position
    for player in players {
      sut.choose(player)
    }

    let result = players.compactMap { $0.position }
    let expected: [Int16] = [1, 2, 3, 4, 5]

    XCTAssertEqual(result, expected)
  }

  func test_choose_callTwice_shouldResetPlayersPositionTo0() {
    PlayerService.addNewPlayer("Dummy", in: coreDataManager.context)
    guard let player = PlayerService.allObjects(Player.self, in: coreDataManager.context).first else {
      XCTFail("Could not fetch player object.")
      return
    }
    sut.choose(player)
    sut.choose(player)

    let expected: Int16 = 0
    XCTAssertEqual(expected, player.position)
  }

  func test_choose_calledTwice_shouldRemovePlayerFromChosenPlayers() {
    PlayerService.addNewPlayer("Dummy", in: coreDataManager.context)
    guard let player = PlayerService.allObjects(Player.self, in: coreDataManager.context).first else {
      XCTFail("Could not fetch player object.")
      return
    }

    sut.choose(player)
    sut.choose(player)

    XCTAssertFalse(sut.chosenPlayers.contains(player))
  }
}
