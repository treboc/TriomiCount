//
//  SubmitPointsAfterGameView.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 26.02.22.
//

import SwiftUI
import Combine

// MARK: - Components / Properties / Views for GameEndingState
struct SubmitPointsAfterGameView: View {
  @EnvironmentObject var vm: GameViewModel
  @FocusState private var textFieldIsFocused: Bool
  @State var endPoints: String = ""
  @State var endPointsIsInt: Bool = true
  
  var body: some View {
      VStack(spacing: 30) {
        Text("How much points do you have left, \(vm.playerToAskForPoints?.name ?? "NO PLAYER")?")
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
          .overlayedAlert(with: "Please enter a valid number!", bool: endPointsIsInt)
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
        // Make sure the maximum input is 999 (no more as 3 digits), because more than this is not realistic and it avoids errors in the system b/c of too high scores.
          .onReceive(Just(endPoints)) { value in
            if value.count > 3 {
              endPoints.removeLast()
            }
          }
        
        Button("Submit") {
          if endPoints.isInt {
            addPoints()
          } else {
            endPointsIsInt = false
          }
        }
        .buttonStyle(.offsetStyle)
        .disabled(!endPoints.isInt)
      }
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          textFieldIsFocused.toggle()
        }
      }
      .padding()
  }
  
  func addPoints() {
    if let endPoints = Int64(endPoints) {
      vm.addPoints(with: endPoints)
      self.endPoints = ""
    }
  }
}

struct SubmitPointsAfterGameView_Previews: PreviewProvider {
  static var previews: some View {
    SubmitPointsAfterGameView()
  }
}
