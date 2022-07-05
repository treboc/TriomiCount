//
//  SessionViewModelTests.swift
//  TriomiCountTests
//
//  Created by Marvin Lee Kobert on 04.07.22.
//

import XCTest
@testable import TriomiCount

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

//  func test_toggleChosenState_shouldAddPlayerToChosenPlayers() {
//    coreDataManager.addPlayer("Dummy", context: coreDataManager.context)
//    let player = coreDataManager.getAllPlayers(coreDataManager.context).first!
//
//    player.toggleIsChosenStatus()
//
//    let expected = Player.getAllChosenPlayers(coreDataManager.context).contains(player)
//
//    XCTAssertTrue(expected)
//  }
//
//  func test_toggleChosenState_ifPlayerIsChosen_PositionShouldNotBe0() {
//    coreDataManager.addPlayer("Dummy", context: coreDataManager.context)
//    let player = coreDataManager.getAllPlayers(coreDataManager.context).first!
//
//    sut.toggleIsChosenState(player)
//
//    let expected: Int16 = 1
//    XCTAssertEqual(expected, player.position)
//  }
//
//  func test_chosenPlayers_positionShouldMatchArray() {
//    // Create 5 players to test on
//    for index in 0..<5 {
//      coreDataManager.addPlayer("Dummy \(index)", context: coreDataManager.context)
//    }
//    let players = coreDataManager.getAllPlayers(coreDataManager.context)
//
//    // Add them all to the chosenPlayersArray and give them a position
//    for player in players {
//      sut.toggleIsChosenState(player)
//    }
//
//    let result = players.compactMap { $0.position }
//    let expected: [Int16] = [1, 2, 3, 4, 5]
//
//    XCTAssertEqual(result, expected)
//  }
//
//  func test_toggleChosenState_ifPlayerIsNotChosen_PositionShouldBe0() {
//    coreDataManager.addPlayer("Dummy", context: coreDataManager.context)
//    let player = coreDataManager.getAllPlayers(coreDataManager.context).first!
//
//    sut.toggleIsChosenState(player)
//    sut.toggleIsChosenState(player)
//
//    let expected: Int16 = 0
//    XCTAssertEqual(expected, player.position)
//  }
}
