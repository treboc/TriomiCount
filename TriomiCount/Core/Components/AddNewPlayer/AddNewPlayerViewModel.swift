//
//  AddNewPlayerViewModel.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 20.05.22.
//

import Combine
import Foundation
import SwiftUI

final class AddNewPlayerViewModel: ObservableObject {
  private(set) var alertMessage: String?
  @Published private(set) var nameValidationState: NameValidationState = .isValid
  @Published var nameTextFieldText: String = ""
  @Published var favoriteColor: UIColor = UIColor.FavoriteColors.colors[0].color
  let allPlayerNames = EntityServiceBase.allObjects(Player.self).map(\.wrappedName)

  fileprivate var cancellables = Set<AnyCancellable>()

  init() {
    subscribeToTextfieldText()
    subscribeToValidationState()
  }

  private func subscribeToTextfieldText() {
    $nameTextFieldText
      .dropFirst()
      .removeDuplicates()
      .debounce(for: 0.1, scheduler: RunLoop.main)
      .sink { [unowned self] _ in
        withAnimation {
          self.nameValidationState = self.validate()
        }
      }
      .store(in: &cancellables)
  }

  private func subscribeToValidationState() {
    $nameValidationState
      .dropFirst()
      .map(\.message)
      .assign(to: \.alertMessage, on: self)
      .store(in: &cancellables)
  }

  func createPlayer(_ completion: () -> Void) {
    guard nameValidationState == .isValid else { return }
    PlayerService.addNewPlayer(nameTextFieldText, favoriteColor: favoriteColor)
    completion()
  }

  func validate() -> NameValidationState {
    let trimmedName = nameTextFieldText.trimmingCharacters(in: .whitespacesAndNewlines)

    if trimmedName.count == 0 {
      return .empty(L10n.AddNewPlayerView.AlertTextFieldEmpty.message)
    } else if trimmedName.count >= 25 {
      return .tooLong(L10n.AddNewPlayerView.AlertNameToLong.message)
    } else if allPlayerNames.contains(trimmedName) {
      return .inUse(L10n.AddNewPlayerView.AlertInUse.message)
    } else {
      return .isValid
    }
  }
}

extension AddNewPlayerViewModel {
  enum NameValidationState: Equatable {
    case inUse(String)
    case empty(String)
    case tooLong(String)
    case isValid

    var message: String? {
      switch self {
      case .isValid:
        return nil
      case .empty(let message):
        return message
      case .tooLong(let message):
        return message
      case .inUse(let message):
        return message
      }
    }
  }
}
