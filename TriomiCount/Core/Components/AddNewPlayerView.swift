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
  @State private var alertMessage: String = ""

  @State private var nameIsValid: Bool = false
  @State private var nameTextFieldText: String = ""
  @State private var favoriteColor: UIColor = .blue

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 30) {
        textLabel

        nameTextField

        FavoriteColorPicker(favoriteColor: $favoriteColor)

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
      .padding(.horizontal)
      .alert(alertTitle, isPresented: $alertIsShown) {
        Button("OK") { textFieldIsFocused = true }
      } message: {
        Text(alertMessage)
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Tesst") {}
      }
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
      HapticManager.shared.notification(type: .error)
      nameIsValid = false
    }
  }
}

struct AddNewPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    AddNewPlayerView()
  }
}

extension AddNewPlayerView {
  private var textLabel: some View {
    Text(L10n.AddNewPlayerView.NameLabel.labelText)
      .underline()
      .font(.title3)
      .fontWeight(.semibold)
      .padding(.leading, 20)
  }

  private var nameTextField: some View {
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
      .textContentType(.givenName)
      .disableAutocorrection(true)
      .focused($textFieldIsFocused, equals: true)
      .keyboardType(.alphabet)
      .submitLabel(.go)
      .onAppear {
        focusTextField()
      }
      .onSubmit {
        createPlayer()
      }
      .onChange(of: nameTextFieldText, perform: { _ in
        if nameTextFieldText.isEmpty {
          alertMessage = L10n.AddNewPlayerView.AlertTextFieldEmpty.message
          nameIsValid = false
        } else if nameTextFieldText.count > 20 {
          alertMessage = L10n.AddNewPlayerView.AlertNameToLong.message
          nameIsValid = false
        } else {
          nameIsValid = true
        }
      })
      .overlayedAlert(with: alertMessage, bool: nameIsValid)
      .overlay(nameTextFieldText.isEmpty ? nil : deleteButton.transition(.move(edge: .trailing)), alignment: .trailing)
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
