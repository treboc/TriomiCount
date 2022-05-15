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
  @State private var alertTitle: String = ""
  private var alertMessage: String {
    if nameTextFieldText.isEmpty {
      return L10n.AddNewPlayerView.AlertTextFieldEmpty.message
    } else if nameTextFieldText.count > 20 {
      return L10n.AddNewPlayerView.AlertNameToLong.message
    } else {
      return ""
    }
  }

  @State private var nameTextFieldText: String = ""
  @State private var nameIsValid: Bool = true
  @State private var favoriteColor: UIColor = .blue

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 30) {
        textFieldLabel
        nameTextField
        FavoriteColorPicker(favoriteColor: $favoriteColor)
        createPlayerButton
      }
      .padding(.horizontal)
    }
  }
}

struct AddNewPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    AddNewPlayerView()
  }
}

extension AddNewPlayerView {
  private var textFieldLabel: some View {
    Text(L10n.AddNewPlayerView.NameLabel.labelText)
      .underline()
      .font(.title3)
      .fontWeight(.semibold)
      .padding(.leading, 20)
  }

  private var nameTextField: some View {
    ZStack(alignment: .trailing) {
      TextField("", text: $nameTextFieldText)
        .placeholder(when: nameTextFieldText.isEmpty, placeholder: {
          Text(L10n.AddNewPlayerView.NameLabel.textfieldText)
            .foregroundColor(.gray)
        })
        .foregroundColor(.primary)
        .padding(.leading, 10)
        .frame(height: Constants.buttonHeight)
        .frame(maxWidth: .infinity)
        .background(Color.secondaryBackground)
        .cornerRadius(Constants.cornerRadius)
        .padding(.horizontal, 20)
        .textInputAutocapitalization(.words)
        .disableAutocorrection(true)
        .focused($textFieldIsFocused, equals: true)
        .keyboardType(.alphabet)
        .submitLabel(.done)
        .onAppear {
          focusTextField()
        }
        .onSubmit {
          createPlayer()
        }
        .onChange(of: nameTextFieldText, perform: isNameValid)
        .overlayedAlert(with: alertMessage, bool: nameIsValid)

      if !nameTextFieldText.isEmpty {
        deleteButton
          .transition(.slide)
      }

    }
  }

  private var createPlayerButton: some View {
    Button {
      createPlayer()
    } label: {
      Text(L10n.AddNewPlayerView.CreateButton.labelText)
        .frame(maxWidth: .infinity)
    }
    .buttonStyle(.offsetStyle)
    .padding(.horizontal, 20)
    .disabled(!nameIsValid)
  }

  private var deleteButton: some View {
    Button(action: {
      nameTextFieldText.removeAll()
    }, label: {
      Image(systemSymbol: .xCircle)
        .font(.headline)
        .foregroundColor(.primary)
    })
    .padding(.trailing, 30)
  }
}

extension AddNewPlayerView {
  struct FavoriteColorPicker: View {
    @Binding var favoriteColor: UIColor
    @State var colorName: String = UIColor.FavoriteColors.colors[0].name

    var body: some View {
      VStack {
        ScrollView(.horizontal, showsIndicators: false) {
          HStack {
            ForEach(UIColor.FavoriteColors.colors, id: \.name) { favColor in
              Circle()
                .fill(
                  Color(uiColor: favColor.color)
                )
                .shadow(color: .black, radius: 3, x: 0, y: 2.5)
                .frame(width: 32, height: 32)
                .onTapGesture {
                  withAnimation {
                    favoriteColor = favColor.color
                    colorName = favColor.name
                  }
                }
            }
          }
          .padding()
        }
        .frame(maxWidth: .infinity)
        .background(Color.secondaryBackground)
        .cornerRadius(Constants.cornerRadius)
        .padding(.horizontal, 20)

        Text(colorName)
          .animation(.none, value: colorName)
      }
    }
  }
}

extension AddNewPlayerView {
  func isNameValid(_ value: String) {
    if nameTextFieldText.isEmpty || nameTextFieldText.count > 20 {
      nameIsValid = false
    } else {
      nameIsValid = true
    }
  }

  func focusTextField() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      textFieldIsFocused = true
    }
  }

  func createPlayer() {
    nameTextFieldText = nameTextFieldText.trimmingCharacters(in: .whitespacesAndNewlines)

    if nameTextFieldText.isValidName {
      Player.addNewPlayer(name: nameTextFieldText, favoriteColor: favoriteColor)
      dismiss()
    } else {
      textFieldIsFocused = false
    }
  }
}
