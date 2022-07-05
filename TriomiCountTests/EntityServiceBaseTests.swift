//
//  EntityServiceBaseTests.swift
//  TriomiCountTests
//
//  Created by Marvin Lee Kobert on 05.07.22.
//

import XCTest
@testable import TriomiCount

class EntityServiceBaseTests: XCTestCase {
//  var sut: EntityServiceBase
  var coreDataManager: CoreDataManager!

  override func setUpWithError() throws {
    coreDataManager = CoreDataManager(.inMemory)
  }

  override func tearDownWithError() throws {
    coreDataManager = nil
  }

  func test_allObjects_shouldReturnAllObjects() {
    let player = Player(name: "Dummy", context: coreDataManager.context)

    let players = EntityServiceBase.allObjects(Player.self, in: coreDataManager.context)

    XCTAssertEqual([player], players)
  }

  func test_object_shouldReturnObjectByObjectID() {
    let player = Player(name: "Dummy", context: coreDataManager.context)
    let objectIDString = player.objectID.uriRepresentation().absoluteString

    guard let expected: Player = EntityServiceBase.object(with: objectIDString, in: coreDataManager.context) else { return }

    XCTAssertEqual(player, expected)
  }

  func test_object_shouldReturnObjectByUUID() {
    let player = Player(name: "Dummy", context: coreDataManager.context)
    guard let id = player.id else { return }

    guard let expected: Player = EntityServiceBase.object(with: id, in: coreDataManager.context) else { return }
    XCTAssertEqual(player, expected)
  }

//  func test_deleteObject() {
//    let player = Player(name: "Dummy", context: coreDataManager.context)
//
//    EntityServiceBase.deleteObject(player, in: coreDataManager.context)
//
//    let objects: [Player] = EntityServiceBase.allObjects(in: coreDataManager.context)
//
//    XCTAssertEqual(0, objects.count)
//  }

}
