//
//  PointsSubmitView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 26.02.22.
//

import SwiftUI
import Combine

struct PointsSubmitView: View {
  @EnvironmentObject var viewModel: SessionViewModel
  @State var endPoints: String = ""
  @State var endPointsIsInt: Bool = true
  @FocusState var textFieldIsFocused

  var body: some View {
    ZStack {
      Color.clear
        .ignoresSafeArea()

      VStack(alignment: .leading, spacing: 30) {
        Text(L10n.PointsSubmitView.labelText((viewModel.playerToAskForPoints != nil) ? viewModel.playerToAskForPoints!.wrappedName : "Unknown player"))
          .font(.headline)

        textField

        HStack {
          if viewModel.playerToAskForPointsIndex != 0 {
            Button(L10n.back) {
              viewModel.playerToAskForPointsIndex -= 1
              endPoints.removeAll()
            }
          }

          Button(viewModel.playerToAskForPointsIndex ==
                 viewModel.playersWithoutLastPlayer.count - 1 ? L10n.submit : L10n.next) {
            if endPoints.isInt {
              addPoints()
            } else {
              endPointsIsInt = false
            }
          }
          .disabled(!endPoints.isInt)
        }
        .buttonStyle(.shadowed)
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
          .fill(.thinMaterial)
          .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 2.5)
      )
      .onChange(of: viewModel.playerToAskForPoints, perform: focusTextFieldAfterSubmit)
      .padding()
    }
  }

  func addPoints() {
    if let endPoints = Int16(endPoints) {
      viewModel.addPoints(with: endPoints)
      self.endPoints = ""
    }
  }
}

struct PointsSubmitView_Previews: PreviewProvider {
  static var previews: some View {
    PointsSubmitView()
  }
}

extension PointsSubmitView {
  private var textField: some View {
    TextField("", text: $endPoints)
      .placeholder(when: endPoints.isEmpty, placeholder: {
        Text("e.g. 42")
          .foregroundColor(.gray)
      })
      .overlayedAlert(with: L10n.PointsSubmitView.overlayAlertMessage,
                      alertIsShown: !endPointsIsInt)
      .animation(.default, value: endPointsIsInt)
      .borderedTextFieldStyle()
      .keyboardType(.numberPad)
      .submitLabel(.go)
      .focused($textFieldIsFocused)
      .onSubmit(addPoints)
      .onChange(of: endPoints, perform: checkEndpointsIsInt)
    /* Make sure the maximum input is 999 (no more as 3 digits),
     because more than this is not realistic and it avoids
     errors in the system b/c of too high scores. */
      .onReceive(Just(endPoints)) { value in
        if value.count > 3 {
          endPoints.removeLast()
        }
      }
      .onAppear {
        textFieldIsFocused = true
      }
  }

  func checkEndpointsIsInt(_ value: String) {
    endPointsIsInt = value.isInt
  }

  func focusTextFieldAfterSubmit(_ player: Player?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      textFieldIsFocused = true
    }
  }
}
