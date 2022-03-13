//
//  AddPlayerView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.01.22.
//

import SwiftUI

struct AddNewPlayerView: View {
  @Environment(\.dismiss) var dismiss
  @FocusState private var textFieldIsFocused: Bool

  @State private var alertIsShown: Bool = false
  @State private var alertTitle: LocalizedStringKey = ""
  @State private var alertMessage: LocalizedStringKey = ""

  @State private var nameTextFieldText: String = ""

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 30) {
        HStack {
          Spacer()
          Button("Cancel") {
            dismiss()
          }
          .foregroundColor(.primaryAccentColor)
          .padding(.top)
        }

        Spacer()

        Text("addNewPlayerView.nameLabel.label_text")
          .font(.title)
          .fontWeight(.semibold)
          .padding(.leading, 20)

        TextField("", text: $nameTextFieldText)
          .padding(.leading, 10)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color.secondaryBackground)
          .cornerRadius(10)
          .padding(.horizontal, 20)
          .textInputAutocapitalization(.words)
          .textContentType(.givenName)
          .disableAutocorrection(true)
          .focused($textFieldIsFocused)
          .onAppear {
            focusTextField()
          }
          .keyboardType(.alphabet)
          .submitLabel(.go)
          .onSubmit {
            createPlayer()
          }

        Button {
          createPlayer()
        } label: {
          Text("addNewPlayerView.createButton.label_text")
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.offsetStyle)
        .padding(.horizontal, 20)

        Spacer()
        Spacer()
      }
      .padding(.horizontal)
      .alert(alertTitle, isPresented: $alertIsShown) {
        Button("OK") { textFieldIsFocused = true }
      } message: {
        Text(alertMessage)
      }
    }
  }

  func focusTextField() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      textFieldIsFocused.toggle()
    }
  }

  func showAlert() {
    if nameTextFieldText.isEmpty {
      alertTitle = "addNewPlayerView.alertTextFieldEmpty.title"
      alertMessage = "addNewPlayerView.alertTextFieldEmpty.message"
    }

    if nameTextFieldText.count > 15 {
      alertTitle = "addNewPlayerView.alertNameToLong.title"
      alertMessage = "addNewPlayerView.alertNameToLong.message"
    }

    alertIsShown.toggle()
    HapticManager.shared.notification(type: .error)
  }

  func nameIsValid() -> Bool {
    if nameTextFieldText.count > 0 && nameTextFieldText.count < 16 {
      return true
    }
    return false
  }
  
  func createPlayer() {
    nameTextFieldText = nameTextFieldText.trimmingCharacters(in: .whitespacesAndNewlines)

    if nameTextFieldText.isValidName() {
      Player.addNewPlayer(name: nameTextFieldText)
      dismiss()
    } else {
      showAlert()
    }
  }
}

struct AddNewPlayerView_Preview: PreviewProvider {
  static var previews: some View {
    AddNewPlayerView()
  }
}
