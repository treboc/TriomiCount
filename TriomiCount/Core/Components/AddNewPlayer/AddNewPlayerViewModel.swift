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
  @Published var textFieldIsFocused: Bool = false

  @Published private(set) var alertMessage: String?
  @Published private(set) var nameValidationState: NameValidationState = .isValid

  @Published var nameTextFieldText: String = ""
  @Published private(set) var nameIsValid: Bool = true
  @Published var favoriteColor: UIColor = UIColor.FavoriteColors.colors[0].color

  fileprivate var cancellables = Set<AnyCancellable>()

  init() {
    subscribeToTextfieldText()
  }

  func subscribeToTextfieldText() {
    $nameTextFieldText
      .dropFirst()
      .debounce(for: 0.2, scheduler: RunLoop.main)
      .sink { [weak self] _ in
        self?.callAlert()
      }
      .store(in: &cancellables)
  }

  func createPlayer(_ completion: () -> Void) {
    guard validate(name: nameTextFieldText) == .isValid else { return }
    let name = nameTextFieldText.trimmingCharacters(in: .whitespacesAndNewlines)
    PlayerService.addNewPlayer(name, favoriteColor: favoriteColor)
    completion()
  }

  func callAlert() {
    withAnimation {
      nameValidationState = validate(name: nameTextFieldText)
      alertMessage = nameValidationState.message
    }
  }

  func validate(name: String) -> NameValidationState {
    let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmedName.count == 0 {
      return .empty(L10n.AddNewPlayerView.AlertTextFieldEmpty.message)
    } else if trimmedName.count >= 25 {
      return .tooLong(L10n.AddNewPlayerView.AlertNameToLong.message)
    } else {
      return .isValid
    }
  }
}

extension AddNewPlayerViewModel {
  enum NameValidationState: Equatable {
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
      }
    }
  }
}
