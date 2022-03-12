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
    let title: String
    let message: String
    let buttonTitle: String
}

struct AlertContext {
    static let exitGame = AlertItem(title: "Are you sure?",
                                   message: "Are you sure you want to exit the game? The state of the game is not saved!",
                                   buttonTitle: "Yes, I'm sure")
    
    static let endGame = AlertItem(title: "Finished the game?",
                                   message: "Are you sure? Make sure, the right player is on turn when the game ends.",
                                   buttonTitle: "Yes, I'm sure.")
}
