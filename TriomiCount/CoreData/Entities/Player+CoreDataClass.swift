//
//  Player+CoreDataClass.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 08.03.22.
//
//

import Foundation
import CoreData

@objc(Player)
public class Player: NSManagedObject {
  var isChosen: Bool = false
}
