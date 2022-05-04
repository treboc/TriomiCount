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
  @FocusState private var textFieldIsFocused: Bool
  @State var endPoints: String = ""
  @State var endPointsIsInt: Bool = true

  var body: some View {
    ZStack {
      Color.clear.ignoresSafeArea()

      VStack(alignment: .leading, spacing: 30) {
        VStack(alignment: .leading, spacing: 0) {
          Text(L10n.PointsSubmitView.labelText(viewModel.playerToAskForPoints!.wrappedName))
        }
        .font(.headline)
        TextField("e.g. 42", text: $endPoints)
          .padding(.leading, 10)
          .frame(height: 55)
          .frame(maxWidth: .infinity)
          .background(Color("SecondaryAccentColor").opacity(0.3))
          .cornerRadius(10)
          .keyboardType(.numberPad)
          .submitLabel(.go)
          .focused($textFieldIsFocused)
          .overlayedAlert(with: L10n.PointsSubmitView.overlayAlertMessage, bool: endPointsIsInt)
          .onSubmit {
            addPoints()
          }
          .onChange(of: endPoints, perform: { newValue in
            if newValue.isInt {
              endPointsIsInt = true
            } else {
              endPointsIsInt = false
            }
          })
          /* Make sure the maximum input is 999 (no more as 3 digits),
             because more than this is not realistic and it avoids
             errors in the system b/c of too high scores. */
          .onReceive(Just(endPoints)) { value in
            if value.count > 3 {
              endPoints.removeLast()
            }
          }

        HStack {
          if viewModel.playerToAskForPointsIndex != 0 {
            Button(L10n.back) {
              viewModel.playerToAskForPointsIndex -= 1
            }
            .buttonStyle(.offsetStyle)
          }

          Button(viewModel.playerToAskForPointsIndex ==
                 viewModel.playersWithoutLastPlayer.count - 1 ? L10n.submit : L10n.next) {
            if endPoints.isInt {
              addPoints()
            } else {
              endPointsIsInt = false
            }
          }
          .buttonStyle(.offsetStyle)
          .disabled(!endPoints.isInt)
        }
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 10)
          .stroke(Color.tertiaryBackground, lineWidth: 2)
          .background(Color.primaryBackground)
      )
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          textFieldIsFocused.toggle()
        }
      }
      .padding()
    }
  }

  func addPoints() {
    if let endPoints = Int64(endPoints) {
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
