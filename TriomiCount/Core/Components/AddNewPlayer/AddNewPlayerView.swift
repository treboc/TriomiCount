//
//  AddPlayerView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 24.01.22.
//

import Combine
import SwiftUI
import SFSafeSymbols

struct AddNewPlayerView: View {
  @Environment(\.dismiss) var dismiss
  @StateObject private var viewModel = AddNewPlayerViewModel()
  @FocusState private var nameTextFieldIsFocused

  var body: some View {
    VStack(alignment: .leading, spacing: 30) {
      textFieldLabel
      nameTextField
      FavoriteColorPicker(favoriteColor: $viewModel.favoriteColor)
      createPlayerButton
    }
    .padding()
    .presentationDetents([.medium])
    .presentationDragIndicator(.visible)
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
      })
      .overlayedAlert(with: viewModel.alertMessage ?? "No alert set", alertIsShown: viewModel.nameValidationState != .isValid)
      .borderedTextFieldStyle()
      .padding(.horizontal, 20)
      .textInputAutocapitalization(.words)
      .disableAutocorrection(true)
      .keyboardType(.alphabet)
      .submitLabel(.done)
      .onSubmit {
        viewModel.createPlayer(dismiss.callAsFunction)
      }
      .overlay(viewModel.nameValidationState == .isValid
               ? nil
               : deleteButton.transition(.opacity), alignment: .trailing)
      .focused($nameTextFieldIsFocused)
      .onAppear { nameTextFieldIsFocused = true }
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
    .disabled(viewModel.nameValidationState != .isValid)
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
                .fill(favColor.color.asColor)
                .padding(4)
                .background(
                  favoriteColor == favColor.color
                  ? Circle()
                    .stroke(favColor.color.asColor, lineWidth: 3)
                    .matchedGeometryEffect(id: "background-stroke", in: namespace)
                  : nil
                )
                .shadow(radius: Constants.shadowRadius)
                .frame(width: 40, height: 34.66)
                .rotationEffect(Angle(degrees:
                                        UIColor.FavoriteColors.colors.firstIndex(of: favColor)?.isMultiple(of: 2) ?? true ? 180 : 0
                                     ))
                .frame(width: 32, height: 32)
                .onTapGesture {
                  withAnimation {
                    favoriteColor = favColor.color
                    colorName = favColor.name
                  }
                }
                .padding(.vertical, 7)
            }
          }
          .padding(.leading, 3)
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
