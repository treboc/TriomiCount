//
//  AddPlayerView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.01.22.
//

import Combine
import SwiftUI

struct AddNewPlayerView: View {
  @Environment(\.presentationMode) var presentationMode
  @StateObject private var viewModel = AddNewPlayerViewModel()
  @FocusState private var textFieldIsFocused

  var body: some View {
    ZStack {
      Color.primaryBackground
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 30) {
        textFieldLabel
        nameTextField
        FavoriteColorPicker(favoriteColor: $viewModel.favoriteColor)
        createPlayerButton
      }
      .padding(.horizontal)
    }
    .onReceive(viewModel.viewDismissalPublisher) { shouldDismiss in
      if shouldDismiss {
        presentationMode.wrappedValue.dismiss()
      }
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
      TextField("", text: $viewModel.nameTextFieldText)
        .placeholder(when: viewModel.nameTextFieldText.isEmpty, placeholder: {
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
        .onAppear(perform: viewModel.focusTextField)
        .onSubmit(viewModel.createPlayer)
        .overlayedAlert(with: viewModel.alertMessage, bool: (viewModel.nameIsValid))
        .onReceive(viewModel.$textFieldIsFocused, perform: { isFocused in
          self.textFieldIsFocused = isFocused
        })
        .onChange(of: viewModel.nameTextFieldText) { _ in viewModel.subscribeToTextfieldText() }
        .onAppear { self.textFieldIsFocused = viewModel.textFieldIsFocused }

      if !viewModel.nameTextFieldText.isEmpty {
        deleteButton
          .transition(.slide)
      }

    }
  }

  private var createPlayerButton: some View {
    Button(action: viewModel.createPlayer) {
      Text(L10n.AddNewPlayerView.CreateButton.labelText)
        .frame(maxWidth: .infinity)
    }
    .buttonStyle(.offsetStyle)
    .padding(.horizontal, 20)
    .disabled(!viewModel.nameIsValid)
  }

  private var deleteButton: some View {
    Button(action: {
      viewModel.nameTextFieldText.removeAll()
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
}
