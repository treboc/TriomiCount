//
//  AlertManager.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 01.03.22.
//

import Foundation
import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: LocalizedStringKey
  let message: LocalizedStringKey
  let buttonTitle: String
}

struct AlertContext {
  static let exitGame = AlertItem(title: "exitGameAlert.title",
                                  message: "exitGameAlert.message",
                                  buttonTitle: "exitGameAlert.buttonTitle")

  static let endGame = AlertItem(title: "endGameAlert.title",
                                 message: "endGameAlert.message",
                                 buttonTitle: "endGameAlert.buttonTitle")
}
