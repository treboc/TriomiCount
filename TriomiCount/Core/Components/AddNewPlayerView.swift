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
  @State private var favoriteColor: UIColor = UIColor.FavoriteColors.colors.first!

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 30) {
        Spacer()

        Text(L10n.AddNewPlayerView.NameLabel.labelText)
          .underline()
          .font(.title3)
          .fontWeight(.semibold)
          .padding(.leading, 20)

        TextField("", text: $nameTextFieldText)
          .placeholder(when: nameTextFieldText.isEmpty, placeholder: {
            Text(L10n.AddNewPlayerView.NameLabel.textfieldText)
              .foregroundColor(.gray)
          })
          .foregroundColor(.white)
          .padding(.leading, 10)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color.secondaryBackground)
          .cornerRadius(20)
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
          .overlay(nameTextFieldText.isEmpty ? nil : deleteButton, alignment: .trailing)

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
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Tesst") {}
      }
    }
  }

  func focusTextField() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      textFieldIsFocused.toggle()
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
  private var deleteButton: some View {
    Button(action: {
      nameTextFieldText.removeAll()
    }, label: {
      Image(systemSymbol: .xCircle)
        .font(.headline)
        .foregroundColor(.white)
    })
    .padding(.trailing, 30)
  }

  struct FavoriteColorPicker: View {
    @Binding var favoriteColor: UIColor

    var body: some View {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(UIColor.FavoriteColors.colors, id: \.self) { color in
            Circle()
              .fill(
                LinearGradient(colors: [Color(uiColor: color).opacity(0.5), Color(uiColor: color)], startPoint: .topLeading, endPoint: .bottomTrailing)
              )
              .frame(width: 32, height: 32)
              .overlay(Circle().strokeBorder(favoriteColor == color ? .gray : .label, lineWidth: favoriteColor == color ? 2 : 0))
              .onTapGesture { favoriteColor = color }
          }
        }
        .padding()
      }
      .frame(height: 55)
      .frame(maxWidth: .infinity)
      .background(Color.secondaryBackground)
      .clipShape(RoundedRectangle(cornerRadius: 20))
      .padding(.horizontal, 20)
    }
  }
}
