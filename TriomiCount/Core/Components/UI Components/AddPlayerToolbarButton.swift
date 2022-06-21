//
//  AddPlayerToolbarButton.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 21.06.22.
//

import SwiftUI

struct AddPlayerToolbarButton: View {
  @Binding var newPlayerSheetIsShown: Bool

  var body: some View {
    Button(iconName: .plus) {
      newPlayerSheetIsShown = true
    }
    .font(.system(.headline, design: .rounded))
  }
}

struct AddPlayerToolbarButton_Previews: PreviewProvider {
    static var previews: some View {
      AddPlayerToolbarButton(newPlayerSheetIsShown: .constant(true))
    }
}
