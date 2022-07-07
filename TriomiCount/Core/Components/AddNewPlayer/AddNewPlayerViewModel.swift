//
//  AddNewPlayerViewModel.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 20.05.22.
//

import Combine
import Foundation
import UIKit

final class AddNewPlayerViewModel: ObservableObject {
  var viewDismissalPublisher = PassthroughSubject<Bool, Never>()
  private var shouldDismiss: Bool = false {
    didSet {
      viewDismissalPublisher.send(shouldDismiss)
    }
  }

  @Published var textFieldIsFocused: Bool = false
  var alertMessage: String {
    if nameTextFieldText.isEmpty {
      return L10n.AddNewPlayerView.AlertTextFieldEmpty.message
    } else if nameTextFieldText.count > 20 {
      return L10n.AddNewPlayerView.AlertNameToLong.message
    } else {
      return ""
    }
  }

  @Published var nameTextFieldText: String = ""
  @Published private(set) var nameIsValid: Bool = true
  @Published var favoriteColor: UIColor = UIColor.FavoriteColors.colors[0].color

  fileprivate var cancellables = Set<AnyCancellable>()

  func subscribeToTextfieldText() {
    if cancellables.isEmpty {
      $nameTextFieldText
        .map { (text) -> Bool in
          if text.isValidName {
            return true
          }
          return false
        }
        .sink { [weak self] isValid in
          self?.nameIsValid = isValid
        }
        .store(in: &cancellables)
    }
  }

  func createPlayer() {
    let name = nameTextFieldText.trimmingCharacters(in: .whitespacesAndNewlines)
    guard name.isValidName else {
      nameIsValid = false
      return
    }
    PlayerService.addNewPlayer(name, favoriteColor: favoriteColor)
    shouldDismiss = true
  }
}
