//
//  PlayerServiceTests.swift
//  TriomiCountTests
//
//  Created by Marvin Lee Kobert on 04.07.22.
//

import XCTest
@testable import TriomiCount

class PlayerServiceTests: XCTestCase {
  var coreDataManager: CoreDataManager!

  override func setUpWithError() throws {
    coreDataManager = CoreDataManager(.inMemory)
  }

  override func tearDownWithError() throws {
    coreDataManager = nil
  }

  func test_addNewPlayer_withNameGiven_hasBasicProperties() {
    PlayerService.addNewPlayer("Dummy", in: coreDataManager.context)

    let player = PlayerService.allObjects(Player.self, in: coreDataManager.context).first!

    let expectedName = "Dummy"
    let favoriteColor = UIColor.clear
    let sessionsPlayed: Int16 = 0
    let sessionsWon: Int16 = 0

    XCTAssertNotNil(player.id)
    XCTAssertEqual(expectedName, player.wrappedName)
    XCTAssertEqual(favoriteColor, player.favoriteColor)
    XCTAssertEqual(sessionsPlayed, player.sessionsPlayed)
    XCTAssertEqual(sessionsWon, player.sessionsWon)
  }

  func test_addNewPlayer_withNameGiven_shouldCreatePlayerEntityWithName() {
    PlayerService.addNewPlayer("Dummy", in: coreDataManager.context)

    let expected = PlayerService.allObjects(Player.self, in: coreDataManager.context).first!

    XCTAssertEqual(expected.wrappedName, "Dummy")
  }

  func test_addNewPlayer_withNameAndFavoriteColorGiven_shouldCreatePlayerEntityWithNameAndFavoriteColor() throws {
    PlayerService.addNewPlayer("Dummy", in: coreDataManager.context)

    let expected = PlayerService.allObjects(Player.self, in: coreDataManager.context).first!

    XCTAssertEqual(expected.wrappedName, "Dummy")
  }

  func test_toggleChosenState_shouldBeChosen() throws {
    let player = Player(name: "Dummy", context: coreDataManager.context)
    PlayerService.toggleChosenState(player)

    let expected = true

    XCTAssertEqual(expected, player.isChosen)
  }

  func test_deletePlayer_afterDeletingPlayer_shouldBeZeroPlayers() {
    let context = coreDataManager.context
    let player = Player(name: "Dummy", context: context)

    var playersCount = PlayerService.countAllObjects(Player.self, context: context)
    XCTAssertEqual(1, playersCount)

    PlayerService.deleteObject(player, in: context)
    playersCount = PlayerService.countAllObjects(Player.self, context: context)
    XCTAssertEqual(0, playersCount)
  }
}
