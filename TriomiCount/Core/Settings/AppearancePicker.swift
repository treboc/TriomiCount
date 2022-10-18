//
//  AppearancePicker.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 21.07.22.
//

import SwiftUI

struct AppearancePicker: View {
  @EnvironmentObject var appearanceManager: AppearanceManager
  @Environment(\.colorScheme) private var colorScheme

  var body: some View {
    Picker("Select Theme", selection: $appearanceManager.appearance) {
      ForEach(AppearanceManager.Appearance.allCases, id: \.self) {
        Text($0.title)
      }
    }
    .pickerStyle(.menu)
  }
}
