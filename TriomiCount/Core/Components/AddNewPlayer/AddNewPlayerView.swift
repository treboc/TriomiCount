//
//  AddPlayerView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.01.22.
//

import Combine
import Introspect
import PageSheet
import SwiftUI
import SFSafeSymbols

struct AddNewPlayerView: View {
  @Environment(\.dismiss) var dismiss
  @StateObject private var viewModel = AddNewPlayerViewModel()

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
    .sheetPreference(.detents([PageSheet.Detent.medium()]))
    .sheetPreference(.cornerRadius(Constants.cornerRadius))
    .sheetPreference(.grabberVisible(true))
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
    TextField("", text: $viewModel.nameTextFieldText)
      .placeholder(when: viewModel.nameTextFieldText.isEmpty, placeholder: {
        Text(L10n.AddNewPlayerView.NameLabel.textfieldText)
          .foregroundColor(.gray)
          .overlayedAlert(with: viewModel.alertMessage, alertIsShown: !viewModel.nameIsValid)
      })
      .borderedTextFieldStyle()
      .padding(.horizontal, 20)
      .textInputAutocapitalization(.words)
      .disableAutocorrection(true)
      .keyboardType(.alphabet)
      .submitLabel(.done)
      .onSubmit {
        viewModel.createPlayer(dismiss.callAsFunction)
      }
      .introspectTextField { $0.becomeFirstResponder() }
      .overlay(viewModel.nameTextFieldText.isEmpty
               ? nil
               : deleteButton.transition(.opacity), alignment: .trailing)
      .animation(.easeIn(duration: 0.1), value: viewModel.nameTextFieldText.isEmpty)
  }

  private var createPlayerButton: some View {
    Button {
      viewModel.createPlayer(dismiss.callAsFunction)
    } label: {
      Text(L10n.AddNewPlayerView.CreateButton.labelText)
        .frame(maxWidth: .infinity)
    }
    .buttonStyle(.shadowed)
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
    @Namespace private var namespace

    var body: some View {
      VStack(spacing: 20) {
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
                .padding(.vertical, 10)
                .padding(.horizontal, 3)
                .overlay(
                  favColor.color == favoriteColor
                  ? Image(systemSymbol: .checkmark)
                    .matchedGeometryEffect(id: "checkmark", in: namespace)
                    .foregroundColor(favColor.color.isDarkColor ? .white : .black)
                    .font(.headline)
                    .animation(.none, value: favoriteColor)
                  : nil
                )
            }
          }
        }

        Text(colorName)
          .font(.system(.headline, design: .rounded))
          .animation(.none, value: colorName)
      }
      .frame(maxWidth: .infinity)
      .foregroundColor(.primary)
      .padding(10)
      .frame(maxWidth: .infinity)
      .background(
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .fill(Color.secondaryBackground)
          .shadow(radius: 3)
      )
      .padding(20)
    }
  }
}
